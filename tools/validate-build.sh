#!/usr/bin/env bash
set -Eeuo pipefail

FILE="$1"

if [[ -z "${FILE:-}" ]]; then
    echo "Usage: validate-build.sh <path/to/build.sh>"
    exit 2
fi

if [[ ! -f "$FILE" ]]; then
    echo "❌ ERROR: File not found: $FILE"
    exit 2
fi

# Ambil nama package dari path, misal: packages/tdoc/build.sh → tdoc
PACKAGE_NAME="$(basename "$(dirname "$FILE")")"

echo "🔎 Validating build.sh → 📦$PACKAGE_NAME"
echo "================================================="

FAIL=0

# ---------- helper ----------
check_var() {
    local var="$1"
    if ! grep -Eq "^${var}=" "$FILE"; then
        echo "❌ FAIL : $var is missing"
        FAIL=1
    else
        echo "✅ OK   : $var"
    fi
}

# ---------- REQUIRED FIELDS ----------
check_var "TERMUX_PKG_HOMEPAGE"
check_var "TERMUX_PKG_DESCRIPTION"
check_var "TERMUX_PKG_LICENSE"
check_var "TERMUX_PKG_MAINTAINER"
check_var "TERMUX_PKG_VERSION"
check_var "TERMUX_PKG_SRCURL"
check_var "TERMUX_PKG_SHA256"

# ---------- BASIC SANITY ----------
if grep -q "dpkg -i" "$FILE"; then
    echo "⚠️  WARN : build.sh contains 'dpkg -i' (not allowed in Termux build)"
fi

if grep -q "sudo " "$FILE"; then
    echo "❌ FAIL : sudo usage detected"
    FAIL=1
fi

if grep -q "apt install" "$FILE"; then
    echo "⚠️  WARN : apt install found (use pkg install instead)"
fi

# ---------- SOURCE SHA256 CHECK ----------
source "$FILE"
eval "SRCURL=\"$TERMUX_PKG_SRCURL\""
EXPECTED_SHA="${TERMUX_PKG_SHA256:-}"

if [[ -n "$SRCURL" && -n "$EXPECTED_SHA" ]]; then
    echo
    echo "🔎 Verifying SHA256 of source package 📦 $PACKAGE_NAME..."
    TMPFILE=$(mktemp)
    if ! curl -sL "$SRCURL" -o "$TMPFILE"; then
        echo "❌ Failed to download source from $SRCURL"
        FAIL=1
    else
        ACTUAL_SHA=$(sha256sum "$TMPFILE" | awk '{print $1}')
        rm -f "$TMPFILE"
        if [[ "$ACTUAL_SHA" != "$EXPECTED_SHA" ]]; then
            echo "❌ SHA256 mismatch!"
            echo "   Expected: $EXPECTED_SHA"
            echo "   Got     : $ACTUAL_SHA"
            FAIL=1
        else
            echo "✅ SHA256 verified"
        fi
    fi
fi

# ---------- RESULT ----------
echo "-------------------------------------------------"
if [[ "$FAIL" -eq 1 ]]; then
    echo "❌ VALIDATION FAILED"
    exit 1
else
    echo "✅ VALIDATION PASSED"
    exit 0
fi
