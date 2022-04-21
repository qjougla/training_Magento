#!/bin/sh

if ! hostname | grep -q '-int$'; then
  echo "This destructive script should only be run on int for now." && exit 1
fi

cd ~/dockerdev && docker-compose down -v --rmi all --remove-orphans

rm -rf ~/dockerdev ~/magento ~/sync-env
