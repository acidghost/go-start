# syntax=docker/dockerfile:1.24.0@sha256:87999aa3d42bdc6bea60565083ee17e86d1f3339802f543c0d03998580f9cb89

FROM golang:1.27.0-alpine@sha256:4c9fe60190a2a3350ddc51de80d0224b8a6698d12bdfc999fee45ea9d6c46dbc AS builder
RUN apk add --no-cache just
WORKDIR /src
COPY go.mod ./
COPY main.go justfile ./
ARG BUILD_VERSION=0.0.0
ARG BUILD_COMMIT=unknown
ARG TARGETOS=linux
ARG TARGETARCH
RUN just version="${BUILD_VERSION}" commit_sha="${BUILD_COMMIT}" build "${TARGETOS}" "${TARGETARCH}" \
    && mv "build/go-start-${TARGETOS}-${TARGETARCH}" /usr/local/bin/go-start

FROM scratch
COPY --from=builder /usr/local/bin/go-start /usr/local/bin/go-start
USER 65532:65532
ENTRYPOINT ["/usr/local/bin/go-start"]
