#!/usr/bin/env bash
# Install the CLI tools the dotfiles expect, user-space only (no sudo, no apt).
# Binaries go in ~/.local/bin, larger bundles in ~/.local/opt.
# Re-run to upgrade to the latest releases.
set -euo pipefail

[[ "$(uname -s)" == Linux ]] || { echo "linux only" >&2; exit 1; }
[[ "$(uname -m)" == x86_64 ]] || { echo "x86_64 only" >&2; exit 1; }

BIN="$HOME/.local/bin"
OPT="$HOME/.local/opt"
SHARE="$HOME/.local/share"
mkdir -p "$BIN" "$OPT" "$SHARE"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

# Print the download URL of the latest release asset of $1 matching regex $2
asset_url() {
  curl -fsSL "https://api.github.com/repos/$1/releases/latest" \
    | grep -o '"browser_download_url": *"[^"]*"' \
    | cut -d'"' -f4 \
    | grep -E "$2" \
    | head -1
}

# Download a tarball and copy the named binary from it into $BIN
install_tar_bin() {
  local name=$1 repo=$2 pattern=$3 dir="$WORK/$1"
  local url
  url="$(asset_url "$repo" "$pattern")"
  [[ -n "$url" ]] || { echo "no asset for $name" >&2; return 1; }
  echo "==> $name: $url"
  mkdir -p "$dir"
  curl -fsSL "$url" | tar -xz -C "$dir"
  install -m 755 "$(find "$dir" -type f -name "$name" | head -1)" "$BIN/$name"
}

# Download a bare binary into $BIN
install_raw_bin() {
  local name=$1 repo=$2 pattern=$3
  local url
  url="$(asset_url "$repo" "$pattern")"
  [[ -n "$url" ]] || { echo "no asset for $name" >&2; return 1; }
  echo "==> $name: $url"
  curl -fsSL "$url" -o "$WORK/$name"
  install -m 755 "$WORK/$name" "$BIN/$name"
}

# Neovim: keep the whole bundle, link the binary
echo "==> nvim"
mkdir -p "$WORK/nvim"
curl -fsSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
  | tar -xz -C "$WORK/nvim"
rm -rf "$OPT/nvim"
mv "$WORK/nvim/nvim-linux-x86_64" "$OPT/nvim"
ln -sfn "$OPT/nvim/bin/nvim" "$BIN/nvim"

install_tar_bin starship starship/starship 'starship-x86_64-unknown-linux-musl\.tar\.gz$'
install_tar_bin eza      eza-community/eza 'eza_x86_64-unknown-linux-musl\.tar\.gz$'
install_tar_bin bat      sharkdp/bat       'x86_64-unknown-linux-musl\.tar\.gz$'
install_tar_bin fd       sharkdp/fd        'x86_64-unknown-linux-musl\.tar\.gz$'
install_tar_bin zoxide   ajeetdsouza/zoxide 'x86_64-unknown-linux-musl\.tar\.gz$'
install_tar_bin fzf      junegunn/fzf      'linux_amd64\.tar\.gz$'
install_raw_bin direnv   direnv/direnv     'direnv\.linux-amd64$'
install_raw_bin mise     jdx/mise          'mise-v[0-9.]+-linux-x64-musl$'

# tree-sitter CLI (nvim-treesitter builds parsers with it)
url="$(asset_url tree-sitter/tree-sitter 'tree-sitter-linux-x64\.gz$')"
echo "==> tree-sitter: $url"
curl -fsSL "$url" | gunzip > "$WORK/tree-sitter"
install -m 755 "$WORK/tree-sitter" "$BIN/tree-sitter"

# Node via mise (mason installs LSP servers with npm)
echo "==> node (mise)"
"$BIN/mise" use -g -y node@lts

# zsh-autosuggestions (sourced from zshrc)
if [[ -d "$SHARE/zsh-autosuggestions/.git" ]]; then
  echo "==> zsh-autosuggestions: pull"
  git -C "$SHARE/zsh-autosuggestions" pull -q --ff-only
else
  echo "==> zsh-autosuggestions: clone"
  git clone -q --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$SHARE/zsh-autosuggestions"
fi

echo "done. tools installed in $BIN"
