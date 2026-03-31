#!/bin/bash
set -euo pipefail

rm -Rf ~/.gnupg

mise trust
eval "$(mise activate bash)"

mise install --yes

/usr/local/bin/post-init.sh
sudo /usr/local/sbin/init-firewall.sh
