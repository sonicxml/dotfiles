#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/aerospace"
mkdir -p "$HOME/.config/zed"
mkdir -p "$HOME/.config/mise"
mkdir -p "$HOME/.config/atuin"
mkdir -p "$HOME/.config/direnv"
mkdir -p "$HOME/.config/raycast"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/zsh-abbr"

ln -snf "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
ln -snf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -snf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

ln -snf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
ln -snf "$DOTFILES_DIR/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
ln -snf "$DOTFILES_DIR/zed/settings.json" "$HOME/.config/zed/settings.json"
ln -snf "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
ln -snf "$DOTFILES_DIR/atuin/config.toml" "$HOME/.config/atuin/config.toml"
ln -snf "$DOTFILES_DIR/direnv/direnvrc" "$HOME/.config/direnv/direnvrc"
ln -snf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -snf "$DOTFILES_DIR/zsh-abbr/user-abbreviations" "$HOME/.config/zsh-abbr/user-abbreviations"

echo "Symlinks complete."
