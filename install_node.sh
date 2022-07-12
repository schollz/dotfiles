#!/usr/bin/env bash


progressfilt ()
{
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c
    do
        if $flag
        then
            printf '%s' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]
            then
                count=0
            else
                ((count++))
                if ((count > 1))
                then
                    flag=true
                fi
            fi
        fi
    done
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  determine_arch
#   DESCRIPTION:  Attempt to determin architecture of host
#    PARAMETERS:  none
#       RETURNS:  0 = Arch Detected. Also prints detected arch to stdout
#                 1 = Unkown arch
#                 20 = 'uname' not found in path
#-------------------------------------------------------------------------------
determine_arch() {
  local uname_out

  if command -v uname >/dev/null 2>&1; then
    uname_out="$(uname -m)"
    if [[ "${uname_out}" == "" ]]; then
      return 1
    else
      echo "${uname_out}"
      return 0
    fi
  else
    return 20
  fi
}

arch="$(determine_arch)"
url="$(wget -qO- https://nodejs.org/en/download/ | grep -oP  'https:\/\/nodejs.org\/dist\/v([0-9\.]+)\/node-v([0-9\.]+)-linux-x64.tar.xz'  | head -n1)"
if [[ "$arch" == *"aarch"* ]]; then
	url="$(wget -qO- https://nodejs.org/en/download/ | grep -oP  'https:\/\/nodejs.org\/dist\/v([0-9\.]+)\/node-v([0-9\.]+)-linux-arm64.tar.xz'  | head -n1)"
fi
if [[ "$arch" == *"arm"* ]]; then
	url="$(wget -qO- https://nodejs.org/en/download/ | grep -oP  'https:\/\/nodejs.org\/dist\/v([0-9\.]+)\/node-v([0-9\.]+)-linux-armv7l.tar.xz'  | head -n1)"
fi
echo "download for ${arch}"
echo "getting ${url}"
wget --progress=bar:force "${url}" -O /tmp/node.tar.xz 2>&1 | progressfilt
rm -rf ~/node
mkdir ~/node
tar -xJf /tmp/node.tar.xz -C ~/node
rm /tmp/node.tar.xz
mv ~/node/node-*/* ~/node/
mkdir ~/node/node_modules
if ! grep -q "node/bin" ~/.zshrc; then
	echo "export PATH=\$PATH:\$HOME/node/bin:\$HOME/node/node_modules/bin" >> ~/.zshrc
	echo "updated ~/.zshrc"
fi
npm config set prefix "$HOME/node/node_modules"
npm install -g npm
npm -v
node -v
