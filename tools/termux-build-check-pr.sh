#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VALIDATOR="$ROOT/tools/validate-build.sh"

FAIL=0

# Ambil target package
TARGET="$1"

# Kalau masih kebawa subcommand
if [[ "$TARGET" == "check-pr" ]]; then
    TARGET="$2"
fi

echo "🔍 Checking packages..."
echo "================================"

if [[ -n "$TARGET" ]]; then
    BUILD="$ROOT/packages/$TARGET/build.sh"
    if [[ ! -f "$BUILD" ]]; then
        echo "❌ Package not found: $TARGET"
        exit 1
    fi

    echo
    echo "📦 $TARGET"
    bash "$VALIDATOR" "$BUILD" || FAIL=1
else
    for BUILD in "$ROOT/packages"/*/build.sh; do
        PKG="$(basename "$(dirname "$BUILD")")"
        echo
        echo "📦 $PKG"
        bash "$VALIDATOR" "$BUILD" || FAIL=1
    done
fi

if [[ $FAIL -eq 0 ]]; then
    echo
    echo "✅ PR looks good"
else
    echo
    echo "❌ PR has issues"
fi

exit $FAIL
