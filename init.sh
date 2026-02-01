#!/bin/bash

set -euo pipefail

if command -v gsed &> /dev/null; then
    SED_CMD="gsed"
elif command -v sed --version 2>&1 | grep -q "GNU"; then
    SED_CMD="sed"
else
    echo "Error: GNU sed is required. Install it with: brew install gnu-sed"
    exit 1
fi

HARD_MODE=false

if [ $# -ge 1 ] && [ "$1" = "--hard" ]; then
    HARD_MODE=true
    shift
fi

if [ $# -ne 2 ]; then
    echo "Usage: $0 [--hard] <organization/username> <package-name>"
    exit 1
fi

ORG="$1"
PKG="$2"
SCRIPT_NAME=$(basename "$0")

find . -type f ! -name "$SCRIPT_NAME" -exec $SED_CMD -i "s|acidghost|$ORG|g" {} \;
find . -type f ! -name "$SCRIPT_NAME" -exec $SED_CMD -i "s|go-start|$PKG|g" {} \;

echo "Replaced 'acidghost' with '$ORG' and 'go-start' with '$PKG' in all files"

if [ "$HARD_MODE" = true ]; then
    cat > README.md << EOF
# $PKG

<!-- TODO -->

## Installation

<!-- TODO -->

## Usage

<!-- TODO -->
EOF

    echo "Updated README.md for package '$PKG'"

    rm UNLICENSE
    echo "Removed UNLICENSE"

    rm "$0"
    echo "Removed $0"
else
    echo "You should now update README.md and delete UNLICENSE and $0"
fi
