#!/usr/bin/env bash
# Dont edit or delete this file
# Termux App Store Official
# Developer: Djunekz
# https://github.com/djunekz/termux-app-store

set -euo pipefail

# =============================================
#  COLORS
# =============================================
R="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
GRAY="\033[90m"
WHITE="\033[97m"
GREEN="\033[32m"
BGREEN="\033[92m"
YELLOW="\033[33m"
BYELLOW="\033[93m"
CYAN="\033[36m"
BCYAN="\033[96m"
BRED="\033[91m"
BG_GREEN="\033[42m"
BG_RED="\033[41m"
BLACK="\033[30m"

# =============================================
#  LINE HELPERS  (warna seragam: GRAY)
# =============================================
_width() {
  local w; w=$(tput cols 2>/dev/null)
  [[ "$w" =~ ^[0-9]+$ ]] && echo "$w" || echo 60
}

_line_heavy() {
  local w; w=$(_width)
  printf "${GRAY}"
  printf '%*s' "$w" '' | tr ' ' '='
  printf "${R}\n"
}

_line_thin() {
  local w; w=$(_width)
  printf "${GRAY}"
  printf '%*s' "$w" '' | tr ' ' '-'
  printf "${R}\n"
}

# =============================================
#  OUTPUT HELPERS
# =============================================
_banner() {
  local w; w=$(_width)
  echo ""
  _line_heavy
  printf "${BOLD}${BCYAN}"
  printf "%*s" $(( (w + 26) / 2 )) "Termux App Store Builder"
  printf "${R}\n"
  printf "${GRAY}"
  printf "%*s" $(( (w + 36) / 2 )) "github.com/djunekz/termux-app-store"
  printf "${R}\n"
  _line_heavy
  echo ""
}

_section() {
  echo ""
  printf "  ${BOLD}${WHITE}:: %s${R}\n" "$1"
  _line_thin
}

_ok()       { printf "  ${BGREEN}[  OK  ]${R}  %s\n"           "$*"; }
_info()     { printf "  ${BCYAN}[ INFO ]${R}  %s\n"            "$*"; }
_warn()     { printf "  ${BYELLOW}[ WARN ]${R}  %s\n"          "$*"; }
_skip()     { printf "  ${GRAY}[ SKIP ]  %s${R}\n"             "$*"; }
_step()     { printf "  ${BCYAN}[  >>  ]${R}  ${BOLD}%s${R}\n" "$*"; }
_progress() { printf "  ${YELLOW}[  ..  ]${R}  %s\n"           "$*"; }
_fatal()    { printf "\n  ${BG_RED}${BLACK}${BOLD} FATAL ${R}  ${BRED}${BOLD}%s${R}\n\n" "$*"; }
_detail()   { printf "      ${GRAY}%-14s${R}  ${WHITE}%s${R}\n" "$1" "$2"; }
_badge()    { printf "  ${GRAY}%-12s${R}  ${BOLD}${WHITE}%s${R}\n" "$1" "$2"; }

# =============================================
#  ARGS & PATHS
# =============================================
PACKAGE="${1:-}"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES_DIR="$ROOT_DIR/packages"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
BUILD_DIR="$PACKAGES_DIR/$PACKAGE"
WORK_DIR="$ROOT_DIR/build/$PACKAGE"
DEB_DIR="$ROOT_DIR/output"

_banner

if [[ -z "$PACKAGE" ]]; then
  _fatal "No package specified"
  printf "  Usage:  $0 ${BOLD}<package-name>${R}\n\n"
  exit 1
fi

BUILD_SH="$BUILD_DIR/build.sh"
if [[ ! -f "$BUILD_SH" ]]; then
  _fatal "build.sh not found for package '${PACKAGE}'"
  _detail "Looked in:" "$BUILD_SH"
  exit 1
fi

source "$BUILD_SH"

# =============================================
#  ARCH
# =============================================
_section "System & Architecture"

case "$(uname -m)" in
  aarch64) ARCH="aarch64" ;;
  armv7l)  ARCH="arm"     ;;
  x86_64)  ARCH="x86_64"  ;;
  i686)    ARCH="i686"    ;;
  *)
    _fatal "Unsupported architecture: $(uname -m)"
    exit 1
    ;;
esac

_badge "  Package :" "${TERMUX_PKG_NAME:-$PACKAGE}"
_badge "  Version :" "${TERMUX_PKG_VERSION:-unknown}"
_badge "  Arch    :" "$ARCH"
_badge "  Prefix  :" "$PREFIX"

# =============================================
#  DEPS
# =============================================
_section "Dependencies"

if [[ -n "${TERMUX_PKG_DEPENDS:-}" ]]; then
  _progress "Installing dependencies..."
  IFS=',' read -ra _DEPS <<< "$TERMUX_PKG_DEPENDS"
  for dep in "${_DEPS[@]}"; do
    dep="$(echo "$dep" | tr -d ' ')"
    printf "      ${GRAY}+${R} ${WHITE}%s${R}\n" "$dep"
  done
  pkg install -y $(tr ',' ' ' <<<"$TERMUX_PKG_DEPENDS")
  _ok "Dependencies installed"
else
  _skip "No dependencies required"
fi

# =============================================
#  DIRS
# =============================================
_section "Preparing Build Environment"

_progress "Cleaning previous build..."
rm -rf "$WORK_DIR"
_progress "Creating directories..."
mkdir -p "$WORK_DIR/src" "$WORK_DIR/pkg" "$DEB_DIR"
_ok "Build environment ready"
_detail "Work dir:"   "$WORK_DIR"
_detail "Output dir:" "$DEB_DIR"

# =============================================
#  DOWNLOAD
# =============================================
_section "Downloading Source"

SRC_FILE="$WORK_DIR/source"
_progress "Fetching source..."
_detail "URL:" "${TERMUX_PKG_SRCURL}"
curl -fL --progress-bar "$TERMUX_PKG_SRCURL" -o "$SRC_FILE"
echo ""
_ok "Download complete"

# =============================================
#  SHA256
# =============================================
if [[ -n "${TERMUX_PKG_SHA256:-}" ]]; then
  _section "Integrity Check (SHA256)"

  if [[ ! -f "$SRC_FILE" ]]; then
    _fatal "Source file not found: $SRC_FILE"
    exit 1
  fi

  _progress "Computing checksum..."
  CALC_SHA256="$(sha256sum "$SRC_FILE" | awk '{print $1}')"

  _detail "Expected:" "${TERMUX_PKG_SHA256}"
  _detail "Got:"      "${CALC_SHA256}"

  if [[ "$CALC_SHA256" != "$TERMUX_PKG_SHA256" ]]; then
    _fatal "SHA256 mismatch! File may be corrupted or tampered."
    exit 1
  fi

  _ok "Checksum verified"
fi

# =============================================
#  EXTRACT
# =============================================
_section "Extracting Source"

PREBUILT_DEB=""
SRC_ROOT="$WORK_DIR/src"

if [[ "$TERMUX_PKG_SRCURL" == *.deb ]]; then
  _skip "Prebuilt .deb detected, skipping extraction"
  PREBUILT_DEB="$SRC_FILE"
elif [[ "$TERMUX_PKG_SRCURL" == *.zip ]]; then
  _progress "Unzipping archive..."
  unzip -q "$SRC_FILE" -d "$SRC_ROOT"
  _ok "Unzip complete"
else
  _progress "Extracting tarball..."
  tar -xf "$SRC_FILE" -C "$SRC_ROOT"
  _ok "Extraction complete"
fi

_SUBDIRS=$(find "$SRC_ROOT" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
_TOPFILES=$(find "$SRC_ROOT" -mindepth 1 -maxdepth 1 -type f 2>/dev/null | wc -l)
if [[ "$_SUBDIRS" -eq 1 && "$_TOPFILES" -eq 0 ]]; then
  SUBDIR="$(find "$SRC_ROOT" -mindepth 1 -maxdepth 1 -type d | head -n1)"
  SRC_ROOT="$SUBDIR"
  _info "Source root flattened to: $(basename "$SUBDIR")"
fi

_detail "Source root:" "$SRC_ROOT"

export TERMUX_PREFIX="$PREFIX"
export TERMUX_PKG_SRCDIR="$SRC_ROOT"
export DESTDIR="$WORK_DIR/pkg"

# =============================================
#  BUILD STEP (NEW!)
# =============================================
if declare -f termux_step_make > /dev/null 2>&1; then
  _section "Building Source"
  _step "Mode: Custom termux_step_make()"
  export TERMUX_PREFIX="$PREFIX"
  cd "$TERMUX_PKG_SRCDIR"
  termux_step_make
  cd "$ROOT_DIR"
  _ok "Build completed"
fi

# =============================================
#  INSTALL
# =============================================
_section "Installing Files (DESTDIR)"

if [[ -n "$PREBUILT_DEB" ]]; then
  _step "Mode: Prebuilt .deb"
  _progress "Extracting .deb contents..."
  dpkg -x "$PREBUILT_DEB" "$WORK_DIR/pkg"

  BIN_FILE="$(find "$WORK_DIR/pkg" -type f -name "$PACKAGE*" -executable | head -n1 || true)"
  if [[ -n "$BIN_FILE" ]]; then
    mkdir -p "$PREFIX/lib/$PACKAGE"
    mv "$BIN_FILE" "$PREFIX/lib/$PACKAGE/$PACKAGE"
    chmod +x "$PREFIX/lib/$PACKAGE/$PACKAGE"
    cat > "$PREFIX/bin/$PACKAGE" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
exec "$PREFIX/lib/$PACKAGE/$PACKAGE" "\$@"
EOF
    chmod +x "$PREFIX/bin/$PACKAGE"
    _ok "Binary installed"
    _detail "Bin:" "$PREFIX/bin/$PACKAGE"
  fi

elif declare -f termux_step_make_install > /dev/null 2>&1; then
  _step "Mode: Custom termux_step_make_install()"
  export TERMUX_PREFIX="$PREFIX"
  cd "$TERMUX_PKG_SRCDIR"
  termux_step_make_install
  cd "$ROOT_DIR"

  _progress "Staging installed files..."
  mkdir -p "$WORK_DIR/pkg$PREFIX/bin" "$WORK_DIR/pkg$PREFIX/lib"

  [[ -f "$PREFIX/bin/$PACKAGE" ]] && \
    install -Dm755 "$PREFIX/bin/$PACKAGE" "$WORK_DIR/pkg$PREFIX/bin/$PACKAGE"
  [[ -d "$PREFIX/lib/$PACKAGE" ]] && \
    cp -r "$PREFIX/lib/$PACKAGE" "$WORK_DIR/pkg$PREFIX/lib/"
  [[ -d "$PREFIX/share/doc/$PACKAGE" ]] && \
    mkdir -p "$WORK_DIR/pkg$PREFIX/share/doc" && \
    cp -r "$PREFIX/share/doc/$PACKAGE" "$WORK_DIR/pkg$PREFIX/share/doc/"

  _ok "Custom install completed"

else
  _step "Mode: Auto-detect main file"

  EXTRACT_ROOT="$WORK_DIR/src"
  MAIN_FILE=""
  [[ -z "$MAIN_FILE" ]] && MAIN_FILE="$(find "$SRC_ROOT"     -maxdepth 1 -type f -name "$PACKAGE.py"         | head -n1 || true)"
  [[ -z "$MAIN_FILE" ]] && MAIN_FILE="$(find "$SRC_ROOT"     -maxdepth 1 -type f -name "$PACKAGE" -perm /111 | head -n1 || true)"
  [[ -z "$MAIN_FILE" ]] && MAIN_FILE="$(find "$SRC_ROOT"     -maxdepth 1 -type f -perm /111                  | head -n1 || true)"
  [[ -z "$MAIN_FILE" ]] && MAIN_FILE="$(find "$SRC_ROOT"     -maxdepth 1 -type f -name "*.py"                | head -n1 || true)"
  [[ -z "$MAIN_FILE" ]] && MAIN_FILE="$(find "$SRC_ROOT"     -maxdepth 1 -type f -name "*.sh"                | head -n1 || true)"
  [[ -z "$MAIN_FILE" ]] && MAIN_FILE="$(find "$EXTRACT_ROOT" -maxdepth 2 -type f -name "$PACKAGE.py"         | head -n1 || true)"
  [[ -z "$MAIN_FILE" ]] && MAIN_FILE="$(find "$EXTRACT_ROOT" -maxdepth 2 -type f -name "$PACKAGE"            | head -n1 || true)"

  if [[ -n "$MAIN_FILE" ]]; then
    BASENAME="$(basename "$MAIN_FILE")"
    COPY_ROOT="$(dirname "$MAIN_FILE")"

    mkdir -p "$WORK_DIR/pkg/$PREFIX/lib/$PACKAGE"
    cp -r "$COPY_ROOT"/. "$WORK_DIR/pkg/$PREFIX/lib/$PACKAGE/"
    mkdir -p "$WORK_DIR/pkg/$PREFIX/bin"

    FIRST_LINE="$(head -n1 "$MAIN_FILE")"
    if [[ "$FIRST_LINE" =~ ^#! ]]; then
      INTERPRETER=$(awk '{print $1}' <<<"$FIRST_LINE" | sed 's|#!||')
    elif [[ "$MAIN_FILE" == *.py ]]; then
      INTERPRETER="python3"
    else
      INTERPRETER="bash"
    fi

    cat > "$WORK_DIR/pkg/$PREFIX/bin/$PACKAGE" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
exec $INTERPRETER "$PREFIX/lib/$PACKAGE/$BASENAME" "\$@"
EOF
    chmod +x "$WORK_DIR/pkg/$PREFIX/bin/$PACKAGE"

    _ok "Main file detected"
    _detail "File:"        "$MAIN_FILE"
    _detail "Interpreter:" "$INTERPRETER"
    _detail "Wrapper:"     "$PREFIX/bin/$PACKAGE"
  else
    _warn "No executable/main file found in $SRC_ROOT"
    _skip "Skipping install step"
  fi
fi

# =============================================
#  CONTROL FILE
# =============================================
_section "Generating Package Metadata"

CONTROL_DIR="$WORK_DIR/pkg/DEBIAN"
mkdir -p "$CONTROL_DIR"
chmod 0755 "$CONTROL_DIR"

cat > "$CONTROL_DIR/control" <<EOF
Package: ${TERMUX_PKG_NAME:-$PACKAGE}
Version: ${TERMUX_PKG_VERSION:-0.0.1}
Architecture: ${ARCH}
Maintainer: ${TERMUX_PKG_MAINTAINER:-unknown}
Description: ${TERMUX_PKG_DESCRIPTION:-No description}
EOF

if [[ -n "${TERMUX_PKG_DEPENDS:-}" ]]; then
  echo "Depends: ${TERMUX_PKG_DEPENDS}" >> "$CONTROL_DIR/control"
fi

_ok "control file written"
_detail "Package:"    "${TERMUX_PKG_NAME:-$PACKAGE}"
_detail "Version:"    "${TERMUX_PKG_VERSION:-0.0.1}"
_detail "Arch:"       "$ARCH"
_detail "Maintainer:" "${TERMUX_PKG_MAINTAINER:-unknown}"

# =============================================
#  BUILD DEB
# =============================================
_section "Building .deb Package"

DEB_FILE="$DEB_DIR/${TERMUX_PKG_NAME:-$PACKAGE}_${TERMUX_PKG_VERSION:-0.0.1}_${ARCH}.deb"
_progress "Running dpkg-deb..."
_detail "Output:" "$(basename "$DEB_FILE")"
dpkg-deb --build "$WORK_DIR/pkg" "$DEB_FILE"
_ok "Package built successfully"

# =============================================
#  INSTALL DEB
# =============================================
_section "Installing Package"

_progress "Running dpkg -i..."
dpkg -i "$DEB_FILE"

# =============================================
#  DONE
# =============================================
echo ""
_line_heavy
printf "  ${BG_GREEN}${BLACK}${BOLD}  DONE  ${R}  "
printf "${BGREEN}${BOLD}%s${R}" "${TERMUX_PKG_NAME:-$PACKAGE}"
printf "${GRAY}  v${TERMUX_PKG_VERSION:-0.0.1}  [${ARCH}]${R}"
printf "${GREEN}  installed successfully${R}\n"
_line_heavy
echo ""
printf "  ${GRAY}Run with:${R}  ${BCYAN}${BOLD}${TERMUX_PKG_NAME:-$PACKAGE}${R}\n"
echo ""
