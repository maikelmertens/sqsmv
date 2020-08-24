FROM golang:latest as builder
WORKDIR /build
COPY ./app /build
RUN make build-linux

FROM scratch
LABEL maintainer="Maikel Mertens"
COPY --from=builder /build/bin/sqsmv-linux /app/sqsmv
ENTRYPOINT ["/app/sqsmv"]
