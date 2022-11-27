#!/bin/bash
# Made with love by Sören Reinecke (Trufi Association e.V.)

# Inspiration:
#   - https://github.com/komoot/photon
#   - https://download1.graphhopper.com/public/extracts/

# Environment variables to declare:
#   - country

# Example declaration of Environment variables:
#country=de

# Script begins
url="https://download1.graphhopper.com/public/extracts/by-country-code/" # Url template

echo "checking if a country has been specified..."
if [ -z "$country" ];
then
	echo -e "  \033[0;31mNo country specified to download the extract for. Exiting script...\033[0;m"
	exit 1
fi;

echo "country has been specified, proceeding with download..."
filenameBZ2="photon-db-$country-latest.tar.bz2"
filenameTar="photon-db-$country-latest.tar"
wget $url/$country/$filenameBZ2

echo "download finish, checking if file exists..."
if [ -d "$filenameBZ2" ];
then
	echo -e "  \033[0;31mAn error while downloading from $url/$country/$filenameBZ2 occurred\033[0;m"
	exit 2
fi;

echo "file exists"
echo "extracting the bz2 archive..."
pbzip2 -d $filenameBZ2
echo "extracting the tar archive..."
tar -xf $filenameTar
exitcode=$?
echo "Extraction finish, execution finish"
exit $exitcode # return the exit code of the tar command
