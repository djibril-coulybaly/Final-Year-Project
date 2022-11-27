#!/bin/sh
[ -d "./data" ] || mkdir "./data"

if ! [ -n "$1" ]; then
    echo 'Error: domain name as param is needed' >&2
    exit 1
fi

if ! [ -d "./data/certbot" ]; then
    cd ./letsencrypt
    /bin/bash ./init-letsencrypt.sh $1
    mv ./data/certbot/ ../data/certbot/
    echo "letsencrypt started"
    cd ../
fi

if ! [ -f "./data/nginx/app.conf" ]; then
    [ -d "./data/nginx" ] || mkdir "./data/nginx"
    sed "s/example.org/$1/" ./nginx/app.template.conf > ./data/nginx/app.conf
    echo "nginx config created"
fi


exit 0