#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# bat-extras | Copyright (C) 2019-2023 eth-p | MIT License
#
# Repository: https://github.com/eth-p/bat-extras
# Issues:     https://github.com/eth-p/bat-extras/issues
# -----------------------------------------------------------------------------
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$GITHUB_WORKSPACE"

# -----------------------------------------------------------------------------
# Overrides from release.sh:
# -----------------------------------------------------------------------------

batextras:get_git_workspace() {
	printf "%s\n" "${GITHUB_WORKSPACE}"
}

batextras:get_current_commit() {
	printf "%s\n" "${GITHUB_SHA:-$(git -C "$GITHUB_WORKSPACE" rev-parse HEAD)}"
}

# -----------------------------------------------------------------------------
# Generate changelog:
# -----------------------------------------------------------------------------
set -euo pipefail
source "${PROJECT_DIR}/release.sh"

zipball_name="bat-extras-$(batextras:get_version | sed 's/\.//')"
zipball="${PROJECT_DIR}/${zipball_name}.zip"
batextras:create_package "$zipball"
