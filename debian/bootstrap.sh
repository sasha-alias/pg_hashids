#!/bin/bash

PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  exit
fi

PG_REPO_APT_SOURCE=/etc/apt/sources.list.d/pgdg.list
if [ ! -f "$PG_REPO_APT_SOURCE" ]
then
  # Add PG apt repo:
  echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > "$PG_REPO_APT_SOURCE"

  # Add PGDG repo key:
  wget --quiet -O - https://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
fi

# Update package list and upgrade all packages
apt-get update
apt-get -y upgrade

apt-get -y install build-essential git postgresql-server-dev-9.3 postgresql-server-dev-9.4 postgresql-server-dev-9.5 postgresql-server-dev-9.6 postgresql-server-dev-10 libpq-dev

echo "Cloning pg_hashids repo..."
rm -rf ~/pg_hashids
git clone https://github.com/wind39/pg_hashids ~/pg_hashids
echo "Done"

for pgv in 10 9.6 9.5 9.4 9.3
do
    echo "Building for PostgreSQL $pgv"
    cd ~/pg_hashids/debian/postgresql-$pgv
    make
    make install
    make deb
    echo "Done"
done
