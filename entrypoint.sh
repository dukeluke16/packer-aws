#!/bin/zsh
set -euo pipefail

export PIPENV_IGNORE_VIRTUALENVS=0

if [ $# -eq 0 ]; then
  pipenv shell --fancy
else
  pipenv run $*
fi
