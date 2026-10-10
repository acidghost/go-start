# syntax=docker/dockerfile:1.27.1@sha256:4edf897a3ffa55b89f906fc8cc78afdb3f1834cc9c7083565e611a8a7d5fe99e

FROM golang:1.27.2-alpine@sha256:85dc1069ac644ea3c527b177303a406eb3358192816cd7f9e5848eb658851673 AS builder
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
