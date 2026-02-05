#!/usr/bin/env bash
set -eo pipefail

PKG="${1:-}"

if [[ -z "$PKG" ]]; then
  echo "❌ Usage: termux-build explain <package>"
  exit 1
fi

FILE="packages/$PKG/build.sh"

if [[ ! -f "$FILE" ]]; then
  echo "❌ build.sh not found for package: $PKG"
  exit 1
fi

# shellcheck disable=SC1090
source "$FILE" || true

echo "🧠 PR Risk Analysis: $PKG"
echo "========================"

RISK=0
WARN=0

fatal() {
  echo "❌ FATAL : $1"
  RISK=1
}

warn() {
  echo "⚠️  WARN  : $1"
  WARN=1
}

ok() {
  echo "✔ OK     : $1"
}

# ---- Mandatory checks (PR blockers)
[[ -z "${TERMUX_PKG_SRCURL:-}"   ]] && fatal "TERMUX_PKG_SRCURL missing"   || ok "SRCURL present"
[[ -z "${TERMUX_PKG_SHA256:-}"  ]] && fatal "TERMUX_PKG_SHA256 missing"  || ok "SHA256 present"
[[ -z "${TERMUX_PKG_VERSION:-}" ]] && fatal "TERMUX_PKG_VERSION missing" || ok "VERSION present"
[[ -z "${TERMUX_PKG_LICENSE:-}" ]] && fatal "TERMUX_PKG_LICENSE missing" || ok "LICENSE present"

# ---- Soft checks (reviewer comments)
[[ -z "${TERMUX_PKG_HOMEPAGE:-}" ]] && warn "No homepage set (optional but recommended)"
[[ -n "${TERMUX_PKG_DESCRIPTION:-}" && ${#TERMUX_PKG_DESCRIPTION} -lt 15 ]] \
  && warn "Description is very short"

# ---- Summary
echo
if [[ $RISK -eq 1 ]]; then
  echo "🚫 High risk: PR likely to be rejected"
elif [[ $WARN -eq 1 ]]; then
  echo "⚠️  Medium risk: PR may get reviewer comments"
else
  echo "🟢 Low risk: PR looks clean and review-friendly"
fi

echo
echo "(Analysis only, no changes made)"
