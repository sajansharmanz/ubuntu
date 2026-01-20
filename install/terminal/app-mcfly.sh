#!/bin/bash

if ! command -v mcfly &> /dev/null; then
  cd /tmp
  curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly
  cd -
else
  echo "mcfly is already installed, skipping."
fi