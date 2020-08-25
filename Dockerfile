FROM golang:latest as builder
WORKDIR /build
COPY ./app /build
RUN make build-linux


FROM alpine:latest
LABEL maintainer="Maikel Mertens"
RUN apk update && \
    apk add ca-certificates && \
    rm -rf /var/cache/apk/*
COPY --from=builder /build/bin/sqsmv-linux /app/sqsmv
ENTRYPOINT ["/app/sqsmv"]
