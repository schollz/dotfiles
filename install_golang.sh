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
url="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | sed 's/^/https:\/\/golang.org\/dl\//g' | head -n 1)"
if [[ "$arch" == *"aarch"* ]]; then
	url="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-arm64\.tar\.gz' | sed 's/^/https:\/\/golang.org\/dl\//g' | head -n 1)"
fi
echo "downloading: ${url}"
wget --progress=bar:force "${url}" -O /tmp/go.tar.gz 2>&1 | progressfilt
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz
if [ -f ~/.zshrc ]; then
if ! grep -q "/usr/local/go/bin" ~/.zshrc; then
	echo "export GOPATH=\$HOME/go" >> ~/.zshrc
	echo "export PATH=\$PATH:\$HOME/go/bin:/usr/local/go/bin" >> ~/.zshrc
	echo "updated ~/.zshrc"
fi
source ~/.zshrc
fi
if [ -f ~/.bashrc ]; then
if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
	echo "export GOPATH=\$HOME/go" >> ~/.bashrc
	echo "export PATH=\$PATH:\$HOME/go/bin:/usr/local/go/bin" >> ~/.bashrc
	echo "updated ~/.bashrc"
fi
source ~/.bashrc
fi
echo "Go installed, logout and login to use \"go\"."
go version
