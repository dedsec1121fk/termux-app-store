#!/data/data/com.termux/files/usr/bin/bash
set -e

APP_NAME="termux-app-store"
INSTALL_DIR="$PREFIX/lib/.tas"
BIN_DIR="$PREFIX/bin"
REPO="djunekz/termux-app-store"
VERSION="latest"

echo "[*] Installing Termux App Store"

# ---------------- ARCH DETECTION ----------------
ARCH=$(uname -m)
case "$ARCH" in
  aarch64) BIN="termux-app-store-aarch64" ;;
  armv7l)  BIN="termux-app-store-arm" ;;
  x86_64)  BIN="termux-app-store-x86_64" ;;
  *)
    echo "[!] Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

# ---------------- ENV CHECK (NON-BLOCKING) ----------------
echo "[*] Checking environment..."

if command -v python >/dev/null 2>&1 || command -v python3 >/dev/null 2>&1; then
    PY_VER=$(python3 --version 2>/dev/null || python --version)
    echo "  ✓ Python detected: $PY_VER"
else
    echo "  ⚠ Python not found (OK for binary)"
fi

if python3 - <<'EOF' >/dev/null 2>&1
import textual
EOF
then
    TXT_VER=$(python3 - <<'EOF'
import textual
print(textual.__version__)
EOF
)
    echo "  ✓ Textual detected: v$TXT_VER"
else
    echo "  ⚠ Textual not found (OK for binary)"
fi

# ---------------- INSTALL ----------------
mkdir -p "$INSTALL_DIR"

URL="https://github.com/$REPO/releases/$VERSION/download/$BIN"

echo "[*] Downloading binary: $BIN"
curl -fL "$URL" -o "$INSTALL_DIR/$APP_NAME"

chmod +x "$INSTALL_DIR/$APP_NAME"

ln -sf "$INSTALL_DIR/$APP_NAME" "$BIN_DIR/$APP_NAME"

# ---------------- DONE ----------------
echo
echo "✔ Installed successfully!"
echo "→ Run with: termux-app-store"
