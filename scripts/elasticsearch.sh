#!/usr/bin/env bash

fancy_echo() {
  printf "\n%b\n" "$1"
}

debInst() {
    dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e


if ! debInst 'elasticsearch'; then
  fancy_echo "Installing & configuring Elasticsearch ..."
    wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
    echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list

    # sudo add-apt-repository ppa:openjdk-r/ppa -y
    # sudo apt-get update
    # sudo apt-get install openjdk-8-jdk -y
    # sudo update-alternatives --config java
    # sudo update-alternatives --config javac

    sudo apt-get update
    sudo aptitude install -y openjdk-7-jdk openjdk-7-jre-headless
    sudo apt-get -y install elasticsearch=1.4.4
    sudo update-rc.d elasticsearch defaults 95 10

    sudo cp -f /home/vagrant/apps/inventory/scripts/files/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
    sudo service elasticsearch restart
fi

