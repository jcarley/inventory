#!/usr/bin/env bash

fancy_echo() {
  printf "\n%b\n" "$1"
}

debInst() {
    dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e


# Install logstash
echo 'deb http://packages.elasticsearch.org/logstash/1.5/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
sudo apt-get update
sudo apt-get install logstash


# Make certs
sudo mkdir -p /etc/pki/tls/certs
sudo mkdir /etc/pki/tls/private

cd /etc/pki/tls
sudo openssl req -subj '/CN=logstash_server_fqdn/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
