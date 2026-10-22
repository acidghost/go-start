# syntax=docker/dockerfile:1.28.0@sha256:bb22d9815c728170f72750f4e5b0d672e06176142e1d602c7e66c050100b7e5b

FROM golang:1.27.3-alpine@sha256:b8c9b82affbbb82a020bbcf998dad2ba9516944ac7e883524642a481a9505e9c AS builder
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
