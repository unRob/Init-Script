#!/bin/bash

# shellcheck source=./util.sh
source "./util.sh"

DOTFILE_REPO="${DOTFILE_REPO:-git@github.com:/unRob/dotfiles.git}"
THIS_REPO="${THIS_REPO:-git@github.com:/unRob/setup-computar.git}"

function install_command_line_tools() {
  local in_progress product os;

  debug "checking for command-line tools..."
  os=$(sw_vers -productVersion | cut -d. -f1,2)

  if softwareupdate --history | grep --silent "Command Line Tools.*${os}"; then
    debug "command-line tools already installed"
  else
    log "installing command-line tools..."
    in_progress="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    touch "${in_progress}"
    product=$(softwareupdate --list | awk "/\* Command Line.*${os}/ { sub(/^   \* /, \"\"); print }")
    softwareupdate --verbose --install "${product}" || errcho "failed to install command-line" 1>&2 && rm ${in_progress} && exit 1
    rm ${in_progress}
    log "command-line tools installed"
  fi
}

function install_package_managers() {
  log "checking for homebrew..."
  if command -v brew; then
    log "homebrew is already installed"
  else
    log "installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || hacf "Failed to install homebrew"
    # https://github.com/Homebrew/brew/issues/1151
    /usr/local/bin/brew update --force
    log "homebrew installed"
  fi

  if [[ ! -d "${HOME}/.asdf" ]]; then
    log "installing asdf..."
    git clone https://github.com/asdf-vm/asdf.git "${HOME}/.asdf" --branch v0.5.1
  fi
}

function setup_dev_env() {
  mkdir -pv "${HOME}/src";
}

function configure_shell() {
  local shell_path

  shell_path="$(command -v zsh)"
  if ! grep "$shell_path" /etc/shells; then
    set -o errexit
    echo "$shell_path" | sudo tee /etc/shells
    set +o errexit
  fi

  current_shell=$(finger -l | grep -oE "Shell: .+" | cut -d ' ' -f 2)
  if [[ "$current_shell" != "$shell_path" ]]; then
    # Change the shell
    log "Changing the shell to zsh"
    set -o errexit
    sudo chsh -s "$shell_path" "$USER"
    set +o errexit
  fi
}

function setup_first_zsh_boot() {
  if [[ ! -f "${HOME}/.zshrc" ]]; then
    local initscript_path
    log "setting up zsh's first-run"
    initscript_path=$(clone_repo "$THIS_REPO")

    chmod +x "${initscript_path}/src/first-run.sh"
    ln -sfv "${initscript_path}/src/first-run.sh" "${HOME}/.zshrc"
  fi
}

function kickstart() {
  if ! _is_app_installed "com.googlecode.iterm2"; then
    log "installing iterm"
    brew cask install "iterm2"
    defaults write com.googlecode.iterm2 "PrefsCustomFolder" "${HOME}/.dotfiles/"
  fi
  banner "Computar is ready for configuration, press any key to continue"
  open -a iTerm
}

banner "Setting up computar, please wait"
install_command_line_tools
setup_dev_env
install_package_managers
configure_shell
setup_first_zsh_boot
kickstart
