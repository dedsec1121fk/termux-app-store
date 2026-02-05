#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

# =========================================================
# Termux App Store — Uninstaller
# =========================================================

APP_NAME="termux-app-store"
INSTALL_DIR="$PREFIX/lib/.tas"
BIN_DIR="$PREFIX/bin"
BIN_LINK="$BIN_DIR/$APP_NAME"
BIN_TARGET="$INSTALL_DIR/$APP_NAME"

# ---------------- UTIL ----------------
die() {
  echo "[!] $*" >&2
  exit 1
}

info() {
  echo "[*] $*"
}

ok() {
  echo "[✓] $*"
}

# ---------------- CONFIRM ----------------
echo "[*] Uninstalling $APP_NAME"
echo
read -r -p "Are you sure you want to uninstall $APP_NAME? [y/N]: " CONFIRM

case "$CONFIRM" in
  y|Y|yes|YES) ;;
  *)
    echo "Aborted."
    exit 0
    ;;
esac

# ---------------- REMOVE SYMLINK ----------------
if [[ -L "$BIN_LINK" ]]; then
  rm -f "$BIN_LINK"
  ok "Removed binary link: $BIN_LINK"
elif [[ -e "$BIN_LINK" ]]; then
  info "Binary exists but is not a symlink, skipping: $BIN_LINK"
else
  info "Binary link not found (already removed)"
fi

# ---------------- REMOVE INSTALL DIR ----------------
if [[ -d "$INSTALL_DIR" ]]; then
  rm -rf "$INSTALL_DIR"
  ok "Removed install directory: $INSTALL_DIR"
else
  info "Install directory not found (already removed)"
fi

# ---------------- DONE ----------------
echo
ok "$APP_NAME has been uninstalled successfully"

echo
info "Notes:"
echo "  - User data was not removed (if any)"
echo "  - Python/Textual were not touched"
