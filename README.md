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
- `build-dir` - Create build directory
- `clean` - Remove build directory
- `fmt` - Format Go code
- `help` - List all available commands
- `install` - Install binary to GOBIN
- `lint` - Run golangci-lint
- `run` / `r` - Build and run the binary
- `vendor` - Tidy and vendor dependencies
