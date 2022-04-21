#!/usr/bin/env bash

set -e #exit on errors

# This script is used to configure grunt for a Magento 2 fresh install

[ ! -f ./Gruntfile.js ] || { echo >&2 "ERROR Cannot configure Grunt : Gruntfile.js already exists!"; exit 1; }

mv Gruntfile.js.sample Gruntfile.js
mv package.json.sample package.json
mv grunt-config.json.sample grunt-config.json
sed -i 's/local-themes/themes/' grunt-config.json
npm install
