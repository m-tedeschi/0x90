#!/usr/bin/env sh
set -eu

PLUGIN_NAME="tiny-rg"
SOURCE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
INSTALL_ROOT="${HOME}/.vim/pack/${PLUGIN_NAME}/start"
INSTALL_DIR="${INSTALL_ROOT}/${PLUGIN_NAME}"

if ! command -v rg >/dev/null 2>&1; then
  echo "tiny-rg: ripgrep is not installed or not on PATH."
  echo "Install ripgrep first, then run this installer again."
  exit 1
fi

mkdir -p "$INSTALL_ROOT"

if [ -e "$INSTALL_DIR" ]; then
  BACKUP_DIR="${INSTALL_DIR}.bak.$(date +%Y%m%d%H%M%S)"
  echo "tiny-rg: existing install found."
  echo "tiny-rg: moving it to $BACKUP_DIR"
  mv "$INSTALL_DIR" "$BACKUP_DIR"
fi

cp -R "$SOURCE_DIR" "$INSTALL_DIR"
chmod +x "$INSTALL_DIR/install.sh"

echo "tiny-rg: installed to $INSTALL_DIR"
echo "tiny-rg: restart Vim, then try :RG runOperation"
