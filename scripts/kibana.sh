#!/usr/bin/env bash

fancy_echo() {
  printf "\n%b\n" "$1"
}

debInst() {
    dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

cd ~; wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz
tar xvf kibana-*.tar.gz

# copy over kibana.yml

# move kibana to new home
sudo mkdir -p /opt/kibana
sudo cp -R ~/kibana-4*/* /opt/kibana/

# Enable and config kibana to run as a service
cd /etc/init.d && sudo wget https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4
sudo chmod +x /etc/init.d/kibana4
sudo update-rc.d kibana4 defaults 96 9
sudo service kibana4 start
