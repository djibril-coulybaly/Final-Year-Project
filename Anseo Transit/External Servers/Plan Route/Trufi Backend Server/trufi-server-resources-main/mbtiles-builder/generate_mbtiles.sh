#!/bin/bash
# created with love by Sören Reinecke (Trufi Association e.V.)
# For small extracts like Hamburg totally fine

 if ! [ -z "$geofabrik_url_path" ];
 then
 # marks the first occurence of char '/' by adding maeker 'ROOT'
 #        |
 #        v
 	path="ROOT$geofabrik_url_path"
 	path=${path//"ROOT/"/}; # remove the first occurence of char '/'
 	path=${path//"ROOT"/}; # remove the marker 'ROOT' if still visible because the previous replace operation did not find "ROOT/"
 	path=${path//".osm.pbf"/};
 	path=${path//"-latest"/};
 else
	path="$1"
 fi

if [ -z "$path" ];
then
	echo -e "\033[0;31mNo url path to doownload region specified!\033[0;m"
	echo -e "\033[0;33mExecute '$0' and specify the url path as argument.\033[0;m"
	echo -e "\033[0;33mUsage: $0 <region name e.g. hamburg>\033[0;m"
	echo -e "\033[0;33mExample: $0 hamburg\033[0;m"
 	exit 1
fi

dataDir="${PWD}/../data/$city/"

remove_openmaptiles_dir() {
	if [ -d "openmaptiles"  ] && ! [ -z `ls -a | grep .git` ];
	then
		echo -e "\033[0;33mRemoving folder 'openmaptiles' in 5 seconds. (Press Ctrl+C to exit this script before it starts the removal process)...\033[0;m"
		sleep 5
		rm -R openmaptiles --verbose --force
	fi
}

echo -e "\033[0;33m########################################\033[0;m"
echo -e "\033[0;33m#     T I L E  G E N E R A T I O N     #\033[0;m"
echo
echo -e "\033[0;33m# RUN THIS ON 64 bit architectures!    #"
echo -e "\033[0;33m# Your kernel needs to support threads!#"
echo
echo -e "\033[0;33m# Operating on tiles '${path}' #\033[0;m"
echo -e "\033[0;33m# This script has dependencies:        #\033[0;m"
echo -e "\033[0;33m#   - bash                             #\033[0;m"
echo -e "\033[0;33m#   - git                              #\033[0;m"
echo -e "\033[0;33m#   - make                             #\033[0;m"
echo -e "\033[0;33m#   - bc                               #\033[0;m"
echo -e "\033[0;33m#   - md5sum                           #\033[0;m"
echo -e "\033[0;33m#   - docker >=1.12.3                  #\033[0;m"
echo -e "\033[0;33m#   - docker-compose >=1.7.1           #\033[0;m"
echo -e "\033[0;33m# Helpers for ressource usage (est.):  #\033[0;m"
echo -e "\033[0;33m#   - regions (disk space): 15-25MB    #\033[0;m"
echo -e "\033[0;33m#   - states (disk space): 25-755MB    #\033[0;m"
echo -e "\033[0;33m#   - countries (disk space): 2-8GB    #\033[0;m"
echo -e "\033[0;33m#   - continents (disk space): 250GB   #\033[0;m"
echo -e "\033[0;33m#   - (Memory) >= 3Gb (depends)        #\033[0;m"
echo -e "\033[0;33m#   - (internet download) >= 1MB/s     #\033[0;m"
echo -e "\033[0;33m#   - (internet total) >= 10GB         #\033[0;m"

echo -e "\033[0;33m########################################\033[0;m"

remove_openmaptiles_dir

echo -e "\033[0;33mCloning OpenMapTiles GitHub repository...\033[0;m"
git clone https://github.com/openmaptiles/openmaptiles.git
cd openmaptiles

echo -e "\033[0;33mInjecting our own '.env' file for OpenMapTiles...\033[0;m"
cat << EOF > .env
# This file defines default environment variables for all images

# Layers definition and meta data
TILESET_FILE=openmaptiles.yaml

# Use 3-part patch version to ignore patch updates, e.g. 5.0.0
TOOLS_VERSION=6.1

# Make sure these values are in sync with the ones in .env-postgres file
PGDATABASE=openmaptiles
PGUSER=openmaptiles
PGPASSWORD=openmaptiles
PGHOST=postgres
PGPORT=5432

# BBOX may get overwritten by the computed bbox of the specific area:
#   make generate-bbox-file
# By default, the Makefile will use the content of data/\$(area).bbox file if it exists.
# Trufi Association modification: BBOX=\$bbox
# Original: BBOX=-180.0,-85.0511,180.0,85.0511
BBOX=$bbox

# Which zooms to generate with   make generate-tiles-pg
MIN_ZOOM=0
# Trufi Association modification: MAX_ZOOM=18 (means a pretty large mbtile)
# Original: MAX_ZOOM=7
#MAX_ZOOM=7
MAX_ZOOM=18

# \`MID_ZOOM\` setting only works with \`make generate-tiles-pg\` command.  Make sure MID_ZOOM < MAX_ZOOM.
# See https://github.com/openmaptiles/openmaptiles-tools/pull/383
# MID_ZOOM=11

# Use  true  (case sensitive) to allow data updates
DIFF_MODE=false

# Some area data like openstreetmap.fr can contain invalid references
# that must be cleaned up before using it for borders -- set it to true.
BORDERS_CLEANUP=false

# The current setup assumes this file is placed inside the data/ dir
MBTILES_FILE=tiles.mbtiles
# This is the current repl_config.json location, pre-configured in the tools Dockerfile
# Makefile and quickstart replace it with the dynamically generated one, but we keep it here in case some other method is used to run.
IMPOSM_CONFIG_FILE=/usr/src/app/config/repl_config.json

# import-borders temp files - set them here to defaults, and override in the Makefile based on the area
BORDERS_CLEANUP_FILE=data/borders/cleanup.pbf
BORDERS_PBF_FILE=data/borders/filtered.pbf
BORDERS_CSV_FILE=data/borders/lines.csv

# Number of parallel processes to use when importing sql files
MAX_PARALLEL_PSQL=5

# Number of parallel threads to use when generating vector map tiles
COPY_CONCURRENCY=10

# Variables for generate tiles using tilelive-pgquery
PGHOSTS_LIST=

EOF

echo -e "\033[0;33mUpdating docker images needed by OpenMapTiles (declared as needed by OpenMapTiles)...\033[0;m"
sudo docker-compose pull

if ! [ -z "$city" ] && [ -d "$dataDir/otp/data" ] && [ -f "$dataDir/otp/data/$city.osm.pbf" ];
then
	# use structure of 'trufi-server-resources' repo and get .osm.pbf file from there
	echo -e "\033[0;33musing 'trufi-server-resources' structure to fetch already downloaded .osm.pbf for $city ...\033[0;m"
	[ -d "./data" ] || mkdir "./data"
	cp "$dataDir/otp/data/$city.osm.pbf" "./data/myregion.osm.pbf" --verbose
	echo -e "\033[0;33mGenerating bbox (calling script made by OpenMapTiles to simplify everything) ...\033[0;m"
	sudo make generate-bbox-file area=myregion
	echo -e "\033[0;33mGenerating mbtiles (calling script made by OpenMapTiles to simplify everything) which now uses the already downloaded .osm.pbf ...\033[0;m"
	sudo bash ./quickstart.sh --empty myregion
else
	echo -e "\033[0;33mGenerating mbtiles (calling script made by OpenMapTiles to simplify everything) ...\033[0;m"
	sudo bash ./quickstart.sh --empty $path
fi

echo -e "\033[0;33mRemoving unnecessary docker images(s) and container(s) (calling script made by OpenMapTiles to simplify everything) ...\033[0;m"
sudo make clean-unnecessary-docker
#make remove-docker-images

cd ../

if ! [ -z "$city" ] && [ -d "$dataDir" ];
then
	sudo chown -R $USER:$USER $dataDir
	echo -e "\033[0;33mCopying important things over to directory '$dataDir/tileserver/data'...\033[0;m"
	[ -d "$dataDir/tileserver" ] || mkdir "$dataDir/tileserver" --verbose
	[ -d "$dataDir/tileserver/data" ] || mkdir "$dataDir/tileserver/data" --verbose
	cp "openmaptiles/data/tiles.mbtiles" "$dataDir/tileserver/data/myregion.mbtiles" --verbose
else # only for debugging
	echo -e "\033[0;33mCopying important things over to directory 'out'...\033[0;m"
	mkdir out
	cp "openmaptiles/data/tiles.mbtiles" "out/myregion.mbtiles" --verbose
fi

# remove_openmaptiles_dir

echo -e "\033[0;33m########################################\033[0;m"
echo -e "\033[0;33m# [ENDED] T I L E  G E N E R A T I O N #\033[0;m"
echo -e "\033[0;33m########################################\033[0;m"

echo -e "\033[1;37mPLEASE credit at the right bottom corner everytime on map display:\033[0;m  © OpenMapTiles © OpenStreetMap contributors"
