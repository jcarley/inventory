#!/usr/bin/env bash

fancy_echo() {
  printf "\n%b\n" "$1"
}

remove_file() {
  if [[ -a "$1" ]]; then
    sudo rm $1
  fi
}

link_file() {
  if [[ ! -h "$2" ]]; then
    sudo ln -s $1 $2
  fi
}

unlink_file() {
  if [[ -h "$1" ]]; then
    sudo unlink $1
  fi
}

remove_site() {
  fancy_echo "Disabling site $1 ..."
    unlink_file "/etc/nginx/sites-enabled/$1"
  fancy_echo "Removing site $1 ..."
    remove_file "/etc/nginx/sites-available/$1"
}

enable_site() {
  fancy_echo "Enabling site $1 ..."
    link_file /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/$1
}

restart_nginx() {
  fancy_echo "Restarting nginx ..."
    sudo service nginx restart >/dev/null
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

fancy_echo "Installing & configuring Nginx, the best webserver around ..."
  # if test ! $(command -v nginx >/dev/null && nginx -v 2>&1 | cut -d ' ' -f 3 | grep "1.6.3"); then
  if ! command -v nginx >/dev/null; then
    source /etc/lsb-release && echo "deb http://nginx.org/packages/mainline/ubuntu/ $DISTRIB_CODENAME nginx" | sudo tee -a /etc/apt/sources.list.d/nginx.list
    source /etc/lsb-release && echo "deb-src http://nginx.org/packages/mainline/ubuntu/ $DISTRIB_CODENAME nginx" | sudo tee -a /etc/apt/sources.list.d/nginx.list
    wget -qO- http://nginx.org/keys/nginx_signing.key | sudo apt-key add -

    # sudo apt-get install python-software-properties -y
    # sudo apt-get install software-properties-common -y
    # sudo add-apt-repository ppa:nginx/stable -y
    sudo apt-get update
    sudo apt-get install -y nginx apache2-utils
  fi
  sudo cp -f /home/vagrant/apps/inventory/scripts/files/nginx/nginx.conf /etc/nginx/nginx.conf

  remove_site "default"


  FILES=/home/vagrant/apps/inventory/scripts/files/nginx/sites/*
  shopt -s nullglob
  for f in $FILES
  do
    sudo cp -f $f /etc/nginx/sites-available/$(basename $f)
    enable_site "$(basename $f)"
  done

  restart_nginx

