#!/bin/bash
rm -rf ./temp/
mkdir ./temp/
mkdir ./temp/otp

wget -O ./input.osm.pbf "https://download.geofabrik.de$geofabrik_url_path"

echo "\033[0;33mExtracting .osm.pbf file ...\033[0;m"
osmium extract --bbox=$bbox  --set-bounds  ./input.osm.pbf  --output "./temp/otp/$city.osm.pbf"

#[ -d "./out/$city" ] || mkdir "./out/$city" # not necessary anymore see docker-compose.
#cp -a ./temp/. ./out/$city
echo "\033[0;33mCopying to appropriate data directory to be of use for other builders ...\033[0;m"
cp -a ./temp/otp/. ./out
