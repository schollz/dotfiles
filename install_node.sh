#!/bin/bash

# installs fnm (Fast Node Manager)
curl -fsSL https://fnm.vercel.app/install | bash

source ~/.zshrc

# download and install Node.js
fnm use --install-if-missing 22

# verifies the right Node.js version is in the environment
node -v # should print `v22.3.0`

# verifies the right NPM version is in the environment
npm -v # should print `10.8.1`
