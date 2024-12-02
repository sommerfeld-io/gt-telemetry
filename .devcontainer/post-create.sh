#!/bin/bash
## Install tools and dependencies for the project.
## This script is run after the devcontainer is created.
##
## @see .devcontainer/devcontainer.json

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

echo "[INFO] Initialize pre-commit"
pre-commit install
