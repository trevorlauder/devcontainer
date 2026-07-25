#!/bin/bash
set -euo pipefail

EXISTING_USER="vscode"
USERNAME="${_REMOTE_USER:-devcontainer}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SHELL="/usr/bin/zsh"
USER_HOME="/home/${USERNAME}"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y
apt-get install -y --no-install-recommends ca-certificates

install -dm 755 /etc/apt/keyrings
install -m 0644 "${SCRIPT_DIR}/mise-gpg-key.pub" /etc/apt/keyrings/mise-archive-keyring.asc
install -m 0644 "${SCRIPT_DIR}/mise.list" /etc/apt/sources.list.d/mise.list

apt-get update
apt-get install -y --no-install-recommends \
    mise \
    cosign \
    curl \
    gzip \
    less \
    procps \
    sudo \
    dnsutils \
    gnupg2 \
    openssh-client \
    zsh \
    git \
    vim \
    build-essential \
    xdg-utils \
    pass \
    file

if [ -n "${PACKAGES:-}" ]; then
  apt-get install -y --no-install-recommends $PACKAGES
fi

if ! id "${USERNAME}" &>/dev/null; then
  usermod -l "${USERNAME}" -d "${USER_HOME}" -s "${SHELL}" -m "${EXISTING_USER}"
  getent group "${EXISTING_USER}" >/dev/null && groupmod -n "${USERNAME}" "${EXISTING_USER}"

  sed -i "s|${EXISTING_USER}|${USERNAME}|g" /etc/sudoers.d/${EXISTING_USER}
  mv /etc/sudoers.d/${EXISTING_USER} /etc/sudoers.d/${USERNAME}
fi

mkdir -p \
  /commandhistory \
  "${USER_HOME}/workspace" \
  "${USER_HOME}/.cache/prek" \
  "${USER_HOME}/.claude" \
  "${USER_HOME}/.config/mise/conf.d" \
  "${USER_HOME}/.config/rtk" \
  "${USER_HOME}/.local/share/rtk"

chown -R "${USERNAME}:${USERNAME}" "${USER_HOME}"

ln -sf "/usr/share/zoneinfo/${TZ:-UTC}" /etc/localtime
echo "${TZ:-UTC}" > /etc/timezone

cat "${SCRIPT_DIR}/zshenv" >> /etc/zsh/zshenv

install -m 0755 "${SCRIPT_DIR}/post-start.sh" /usr/local/bin/post-start.sh

su - "${USERNAME}" -c "curl -fsSL --retry 5 --retry-connrefused --retry-all-errors https://claude.ai/install.sh | bash"

apt autoremove -y
rm -rf /var/lib/apt/lists/*
