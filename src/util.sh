# shellcheck shell=bash

function banner() {
  log "--------"
  log "$1"
  log "--------"
}

function log() {
  echo "$@"
}

function debug() {
  if [[ $DEBUG != '' ]]; then
    echo "$@"
  fi
}

function errcho() {
  >&2 echo "$@"
}

function hacf() {
  errcho ""
  errcho "ERROR!"
  errcho "$@"
  exit 1
}

function clone_repo() {
  local repo_url repo_host repo_path workdir
  repo_url="$1"
  # prepend // if repo has no protocol set so ruby doesn't explode
  [[ $repo_url != *"//"* ]] && repo_url=//${repo_url}
  repo_host=$(ruby -ruri -e "p URI.parse('$repo_url').host")
  repo_path=$(ruby -ruri -e "p URI.parse('$repo_url').path")
  workdir="${HOME}/src/${repo_host}/${repo_path}"

  debug "mkdir -p $1"
  mkdir -p "$(dirname "$workdir")"
  debug "git clone $1 $workdir"
  git clone "$1" "$workdir" >/dev/null
  echo "$workdir"
}

function _is_app_installed () {
  osascript -e "tell application \"Finder\" to POSIX path of (get application file id \"$1\" as alias)" > /dev/null 2>&1
}

