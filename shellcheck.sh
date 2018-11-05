#!/bin/bash

find . -name "*.sh" -type f -print0 | while IFS= read -r -d '' file; do
  if [ "$file" == "./entrypoint.sh" ]; then
    # skip known file
    continue;
  fi

  shellcheck --format=gcc "$file";
done;
