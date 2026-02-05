#!/usr/bin/env bash
set -eo pipefail

PKG="${1:-}"

if [[ -z "$PKG" ]]; then
  echo "❌ Usage: termux-build suggest <package>"
  exit 1
fi

FILE="packages/$PKG/build.sh"

if [[ ! -f "$FILE" ]]; then
  echo "❌ build.sh not found for package: $PKG"
  exit 1
fi

# shellcheck disable=SC1090
source "$FILE" || true

echo "💡 Suggestions for $PKG"
echo "======================="

SUGGESTIONS=0

suggest_missing() {
  if [[ -z "${!1:-}" ]]; then
    echo "- add $1=\"...\""
    SUGGESTIONS=1
  fi
}

suggest_quality() {
  local val="${!1:-}"
  if [[ -n "$val" && ${#val} -lt 10 ]]; then
    echo "- consider improving $1 (too short)"
    SUGGESTIONS=1
  fi
}

# Required fields
suggest_missing TERMUX_PKG_HOMEPAGE
suggest_missing TERMUX_PKG_DESCRIPTION
suggest_missing TERMUX_PKG_LICENSE
suggest_missing TERMUX_PKG_MAINTAINER
suggest_missing TERMUX_PKG_VERSION
suggest_missing TERMUX_PKG_SRCURL
suggest_missing TERMUX_PKG_SHA256

# Quality hints
suggest_quality TERMUX_PKG_DESCRIPTION
suggest_quality TERMUX_PKG_HOMEPAGE

if [[ $SUGGESTIONS -eq 0 ]]; then
  echo "✔ No suggestions — build.sh already looks solid"
fi
