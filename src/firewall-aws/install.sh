#!/bin/bash
set -euo pipefail

FEATURE_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p /usr/local/etc/firewall-extra-fqdns.d

jq -r '
    .partitions[] | select(.partition == "aws") |
    . as $partition |
    .services | to_entries[] | . as $service |
    .value.endpoints | to_entries[] |
    if .value.hostname then .value.hostname
    else "\($service.key).\(.key).\($partition.dnsSuffix)"
    end
' "${FEATURE_DIR}/botocore-endpoints.json" | sort -u \
    > /usr/local/etc/firewall-extra-fqdns.d/feature-firewall-aws-fqdns.txt
