TERMUX_PKG_HOMEPAGE=https://github.com/djunekz/pmcli
TERMUX_PKG_DESCRIPTION="Terminal-based project manager CLI"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Djunekz <gab288.gab288@passinbox.com>"
TERMUX_PKG_VERSION=0.1.0
TERMUX_PKG_SRCURL=https://github.com/djunekz/pmcli/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
#TERMUX_PKG_SRCURL=https://github.com/djunekz/pmcli/releases/download/v${TERMUX_PKG_VERSION}/pmcli-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS="rust, openssl, zlib"

termux_step_extract_package() {
    echo "==> Extracting source..."
    mkdir -p "$TERMUX_PKG_SRCDIR"
    unzip -q "$WORK_DIR/source" -d "$WORK_DIR/src"

    SRC_ROOT="$(find "$WORK_DIR/src" -mindepth 1 -maxdepth 1 -type d | head -n1)"
    mv "$SRC_ROOT" "$TERMUX_PKG_SRCDIR"
    echo "[*] Source root: $TERMUX_PKG_SRCDIR"
}

termux_step_make() {
    echo "==> Building pmcli..."
    cd "$TERMUX_PKG_SRCDIR" || exit 1

    # deteksi target Rust
    case "$(uname -m)" in
        aarch64) RUST_TARGET="aarch64-linux-android" ;;
        armv7l)  RUST_TARGET="armv7-linux-androideabi" ;;
        x86_64)  RUST_TARGET="x86_64-linux-android" ;;
        i686)    RUST_TARGET="i686-linux-android" ;;
        *) echo "[FATAL] Unsupported arch"; exit 1 ;;
    esac

    echo "[*] Using Rust target: $RUST_TARGET"
    cargo build --release --target "$RUST_TARGET"
}

termux_step_make_install() {
    echo "==> Installing pmcli binary..."
    cd "$TERMUX_PKG_SRCDIR" || exit 1

    case "$(uname -m)" in
        aarch64) RUST_TARGET="aarch64-linux-android" ;;
        armv7l)  RUST_TARGET="armv7-linux-androideabi" ;;
        x86_64)  RUST_TARGET="x86_64-linux-android" ;;
        i686)    RUST_TARGET="i686-linux-android" ;;
    esac

    BIN_PATH="target/$RUST_TARGET/release/pmcli"
    if [[ ! -f "$BIN_PATH" ]]; then
        echo "[FATAL] Binary not found: $BIN_PATH"
        exit 1
    fi

    install -Dm700 "$BIN_PATH" "$TERMUX_PREFIX/bin/pmcli"
    echo "[✔] pmcli installed to $TERMUX_PREFIX/bin/pmcli"
}
