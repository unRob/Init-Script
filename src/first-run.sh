# shellcheck shell=bash

# shellcheck source=util.sh
source "./util.sh"

banner "Configuring computar's software, hang tight"

rm "${HOME}/.zshrc"

if [[ ! -d "$HOME/.dotfiles" ]] || [[ ! -L "$HOME/.dotfiles" ]]; then
  log "Getting some dotfiles"
  debug "DOTFILE_REPO='${DOTFILE_REPO}'"

  set -o errexit
  dotfile_path=$(clone_repo "$DOTFILE_REPO" >/dev/null)
  pushd "$dotfile_path"
  make setup
  popd "$dotfile_path"
  set +o errexit
fi

if [[ -d "${HOME}/.Brewfile" ]]; then
  log "installing homebrew packages"
  brew bundle --global
fi

if [[ -d "${HOME}/.asdf" ]]; then
  log "installing tools from .tool-versions..."
  cut -d ' ' -f 1 "${HOME}/.tool-versions" | while read -r plugin; do
    asdf plugin-add "$plugin";
  done
  asdf install
fi

banner "All set, let's setup some stuff..."
source ~/.zshrc
create_computar_profile
