#!/usr/bin/env bash

/home/vagrant/apps/inventory/scripts/base.sh
/home/vagrant/apps/inventory/scripts/redb-database.sh
/home/vagrant/apps/inventory/scripts/nginx.sh
/home/vagrant/apps/inventory/scripts/elasticsearch.sh
sudo -u vagrant -H bash -c "/home/vagrant/apps/inventory/scripts/ruby.sh"

