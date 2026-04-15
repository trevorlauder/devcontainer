#!/bin/bash
set -euo pipefail

PACKAGES="%PACKAGES%"
BREW="/home/linuxbrew/.linuxbrew/bin/brew"

sudo /usr/local/sbin/feature-homebrew-post-start-root.sh

${BREW} config

if [ -n "${PACKAGES}" ]; then
  ${BREW} install ${PACKAGES}
fi
