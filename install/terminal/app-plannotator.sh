#!/bin/bash

# Install Plannotator, an open-source planning & code-review tool.
# See https://docs.plannotator.ai/open-source/start/installation
# Installs the `plannotator` command and agent hooks/skills.
# Run non-interactively (reads defaults) since stdin is the install script, not a tty.
curl -fsSL https://plannotator.ai/install.sh | bash
