# dotfiles

## New machine setup

```sh
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone this repo (scripts assume ~/dotfiles)
git clone <repo-url> ~/dotfiles && cd ~/dotfiles

# 3. Install packages, casks, and fonts
brew bundle

# 4. Symlink configs into ~ and ~/.config
./install/symlinks.sh

# 5. Restore Moom window layouts
./moom/import.sh

# 6. Reload the shell
exec zsh
```

## Afterwards

- Put machine-specific secrets and overrides in `~/.zsh.local` (sourced by zshrc, not tracked).
- Sign in to 1Password, Moom (license + Accessibility permission), and `atuin login`.
- Neovim installs its plugins on first launch.

## Keeping in sync

- `brew bundle dump --force` to update the Brewfile.
- `./moom/export.sh` to snapshot Moom settings after changing them.
