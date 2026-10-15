#!/usr/bin/env bash
# One-command install of the RustGIS MCP server for the LIC IBZ lab finale.
# Run this once, then type /reload-mcp in your Hermes session.
set -euo pipefail

VER=0.2.0
DEST="$HOME/.local/opt/rustgis"
mkdir -p "$DEST"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux*)
    if [ "$ARCH" != "x86_64" ]; then
      echo "Unsupported Linux arch: $ARCH (need x86_64)." >&2; exit 1
    fi
    URL="https://github.com/opengeos/RustGIS/releases/download/v$VER/RustGIS-$VER-linux-x86_64.tar.gz"
    ;;
  Darwin*)
    case "$ARCH" in
      arm64) A=aarch64 ;;
      *)     A=x86_64 ;;
    esac
    URL="https://github.com/opengeos/RustGIS/releases/download/v$VER/rustgis-cli-$VER-macos-$A.tar.gz"
    ;;
  *)
    cat <<EOF
Windows: download RustGIS-$VER-windows-x86_64-portable.zip from
https://github.com/opengeos/RustGIS/releases/latest , unzip it to a folder,
then run in your terminal:

  hermes mcp add rustgis --command "<folder>/rustgis-cli.exe" --connect-timeout 60 --args mcp --yes

(Answer Y when asked to enable the tools.) Then type /reload-mcp in your Hermes session.
EOF
    exit 0
    ;;
esac

echo "Downloading RustGIS $VER for $OS/$ARCH (~30 MB)…"
curl -fSL "$URL" -o /tmp/rustgis.tar.gz
tar -xzf /tmp/rustgis.tar.gz -C "$DEST"

CLI="$(find "$DEST" -name "rustgis-cli*" -type f | head -1)"
if [ -z "$CLI" ]; then
  echo "Could not find rustgis-cli in $DEST — check the extracted files." >&2
  exit 1
fi
chmod +x "$CLI"

echo "Wiring the MCP server into Hermes…"
printf 'Y\n' | hermes mcp add rustgis --command "$CLI" --connect-timeout 60 --args mcp --yes

cat <<EOF

Done. Now:
1. Type /reload-mcp in your Hermes session (no restart needed).
2. Test: ask your agent "list the rustgis tools you have available".
EOF
