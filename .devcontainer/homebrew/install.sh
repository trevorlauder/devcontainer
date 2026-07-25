#!/bin/bash
set -euo pipefail

USERNAME="${_REMOTE_USER:-devcontainer}"

BREW_VERSION="5.1.5"
HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"

mkdir -p "${HOMEBREW_PREFIX}/Homebrew" "${HOMEBREW_PREFIX}/bin"
chown -R "${USERNAME}:${USERNAME}" /home/linuxbrew

su "${USERNAME}" -c "
  curl -fsSL 'https://github.com/Homebrew/brew/archive/refs/tags/${BREW_VERSION}.tar.gz' | \
    tar -xz --strip-components=1 -C '${HOMEBREW_PREFIX}/Homebrew' && \
  ln -sf '../Homebrew/bin/brew' '${HOMEBREW_PREFIX}/bin/brew'
"
