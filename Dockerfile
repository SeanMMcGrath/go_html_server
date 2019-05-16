FROM golang:latest AS build

WORKDIR /go/src/github.com/SeanMMcGrath/go_html_server
COPY . .

RUN go get -d -v ./...

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o main .

FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add ca-certificates && \
    apk add tzdata

WORKDIR /root/

COPY --from=build /go/src/github.com/SeanMMcGrath/go_html_server/main ./

RUN env && pwd && find .

CMD ./main
