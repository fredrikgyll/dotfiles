#!/usr/bin/env bash
# Symlink dotfiles into $HOME. Works on macOS and Linux.
# Existing files (not already our symlinks) are moved to ~/.dotfiles-backup/<timestamp>/.
# On Linux, pass --tools to also install CLI tools via bootstrap/linux.sh.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$DOTFILES/$1" dst="$HOME/$2"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok      $dst"
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$BACKUP/$(dirname "$2")"
    mv "$dst" "$BACKUP/$2"
    echo "backup  $dst -> $BACKUP/$2"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link    $dst -> $src"
}

if [[ "${1:-}" == --tools ]]; then
  case "$(uname -s)" in
    Linux) "$DOTFILES/bootstrap/linux.sh" ;;
    *) echo "--tools is Linux only; use Homebrew on macOS" >&2 ;;
  esac
fi

link zshenv               .zshenv
link zprofile             .zprofile
link zshrc                .zshrc
link config/nvim          .config/nvim
link config/starship.toml .config/starship.toml
