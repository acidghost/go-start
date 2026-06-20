# go-start

A starter template for Go projects with batteries included.

> [!note]
> This template is tailored for my own needs.
> Issues and PRs might not be taken into consideration.

## Features

- **Multi-platform builds**: Automatically builds for Darwin/arm64, Linux/arm64, and Linux/amd64
- **CI/CD pipeline**: Comprehensive GitHub Actions workflows for CI and nightly releases
- **Code quality**: Pre-configured `golangci-lint` with sensible defaults
- **Task runner**: Just commands for common development tasks
- **Easy customization**: `init.sh` script to bootstrap your new project
- **Automated updates**: Dependabot integration for dependency management
- **Build metadata**: Binaries embed version, commit SHA, and build time
- **Supply-chain hardening**: Published images and release binaries include provenance metadata

## Quick Start

Use the init script to create your new project:

```bash
./init.sh <organization/username> <package-name>
```

For a fresh start with a proper README:

```bash
./init.sh --hard <organization/username> <package-name>
```

## Development

Available commands:

- `build` / `b` - Build binary for current platform
- `build-all` - Build for all platforms (darwin/arm64, linux/arm64, linux/amd64)
- `build-image` - Build the container image
- `build-dir` - Create build directory
- `clean` - Remove build directory
- `fmt` - Format Go code
- `help` - List all available commands
- `install` - Install binary to GOBIN
- `lint` - Run golangci-lint
- `run` / `r` - Build and run the binary
- `vendor` - Tidy and vendor dependencies

## Supply-chain hardening

The container build path is intentionally small:

- The Dockerfile uses pinned base images.
- `.dockerignore` keeps local build output, Git data, and editor/env files out of the build context.
- The `Publish Image` workflow pushes to GHCR with max-level provenance, an SBOM, and a keyless cosign signature.
- The `Nightly` workflow publishes binary tarballs with `SHA256SUMS` and GitHub artifact attestations.

Build an image locally:

```bash
just build-image
```

Use Podman without changing the justfile:

```bash
just container_engine=podman build-image
```

Publish from GitHub Actions by manually running the `Publish Image` workflow.

Verify a published image:

```bash
cosign verify ghcr.io/<owner>/<repo>:latest \
  --certificate-identity-regexp 'https://github.com/<owner>/<repo>/.github/workflows/publish-image.yaml@.*' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```

Verify a downloaded release tarball:

```bash
sha256sum -c SHA256SUMS
gh attestation verify go-start-linux-amd64.tar.gz --repo <owner>/<repo>
```
