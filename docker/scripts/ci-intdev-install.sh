#!/bin/sh

# from https://git.clever-age.net/PROJECT/docker/-/blob/master/doc/install-guide.md
# This script and the doc should be kept in sync for the CI to work properly !!

echo "TODO configure this script with your PROJECT" && exit 1

COMPOSEPREFIX=xxxxxx_
DEVHOST="example.com.localhost"
TESTHOST="devtest.example.fr.aws.projects.clever-age.net"
GITREPO_DOCKER="git@git.clever-age.net:PROJECT/docker.git"
GITREPO_MAGENTO="git@git.clever-age.net:PROJECT/magento.git"
GITREPO_SYNCENV="git@git.clever-age.net:PROJECT/sync-envgit"
REFDUMP="PROJECT-qa:dumps/magento.sql.gz"

# exit on errors
set -ex

if docker ps --format '{{.Names}}' | grep -v "$COMPOSEPREFIX"
then
	echo "Error there are other containers running not matching $COMPOSEPREFIX. Please stop them." && exit 1
fi


# build
[ ! -d ~/dockerdev ] && git clone "$GITREPO_DOCKER" ~/dockerdev

cd ~/dockerdev
scripts/check-requirements.sh
#ln -sfT docker-compose.restart.yml docker-compose.override.yml

[ ! -d ~/magento ] && git clone "$GITREPO_MAGENTO" ~/magento

make # create the .env file

sed -i "s/admin-$DEVHOST/admin.$TESTHOST/g" .env
sed -i "s/$DEVHOST/$TESTHOST/g" .env

make startd
sleep 5

[ "$(docker-compose ps |grep -v -e Name -e ---- -e ' Up ')" != "" ] && echo "ERROR some containers are not up" && exit 1

# with -T avoid "the input device is not a TTY" error
./run exec -T -u www-data php composer install

# 6a from doc
#execArgs="-T" make magento-setup-install

# 6b from doc
cp -v ~/dockerdev/env.php ~/magento/app/etc/env.php

# get the reference dump
rsync -avL "$REFDUMP" ~/magento/
[ ! -d ~/sync-env ] && git clone "$GITREPO_SYNCENV" ~/sync-env
sed -i "s/$DEVHOST/$TESTHOST/g" ~/sync-env/sql.dev/after-db-import.sql.local

yes | ./run exec -T -u www-data php /scripts/import-magento-db

./run exec -T -u www-data php bin/magento module:disable Magento_TwoFactorAuth
# end 6b from doc

# test
sleep 1
URL="https://$TESTHOST/"
OUTPUT=$(curl -s -o/dev/null -k -w "%{http_code}" "$URL")
if [ "$OUTPUT" = 200 ]; then
	echo "Curl OK: $URL"
else
	echo "Curl ERROR ($OUTPUT): $URL"
	exit 1
fi
