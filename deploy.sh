#!/bin/bash
if [ -z $1 ]; then
  echo "Usage: ./deploy.sh [host]"
  exit
fi

host="${1}"

echo "[*] Moving in to $host"

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null

tar cj . | ssh -o 'StrictHostKeyChecking no' "$host" '
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
sudo bash install.sh'
