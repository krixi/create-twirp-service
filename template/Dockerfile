FROM golang:1.14-alpine as builder

RUN apk update && apk upgrade && \
    apk add -U --no-cache ca-certificates

COPY . /go/src/SVCPATH
WORKDIR /go/src/SVCPATH

RUN go build -o /SVCNAME ./SVCPATH/cmd/PKGNAME/*.go

FROM alpine as runner

COPY --from=builder /SVCNAME /SVCNAME
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/SVCNAME"]

