#!/bin/bash
# @file .release.sh
# @brief Handle tasks from the release process (semantic release).
# @description
#     This script is used to handle tasks from the release process (semantic release).
#     It is called by the semantic-release tool, which is configured in the .releaserc file.
#     The script is responsible for incrementing the version numbers in the yaml files.
#     The version inside the yaml files is expected to be in the format: `version: 0.1.0`.
#
# @arg $1 string The version that should be written to the files.

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

VERSION="$1"

# @description Increment the version numbers in all yaml files, that contain the version number.
# The version inside the yaml files is expected to be in the format: `version: 0.1.0`.
#
# @arg $1 string The version that should be written to the files.My super function.
function incrementVersionsInYaml() {
    yaml_files=(
        #"components/test-compliance/gt-telemetry/inspec.yml"
    )

    for file in "${yaml_files[@]}"; do
        sed -i "s/version: .*/version: $VERSION/" "$file"
    done
}

incrementVersionsInYaml
