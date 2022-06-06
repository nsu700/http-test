FROM golang:1.18
WORKDIR /usr/src/http
COPY main.go go.mod .
RUN go mod tidy &&  GOOS=linux go build -v -o /go-http /usr/src/http

FROM debian
WORKDIR /usr/local/bin/
COPY --from=0 /go-http .
EXPOSE 8090
ENTRYPOINT /usr/local/bin/go-http
