#!/bin/bash

if [[ $1 == "django" ]]; then
    source activate hire_me_now
    pip install $2
    STATUS=development docker-compose up -d django

elif [[ $1 == "react" ]]; then
    cd react && npm install $2 --save

elif [[ $1 == "express" ]]; then
    cd express && npm install $2 --save

elif [[ $1 == "--deploy" || $1 == "-d" ]]; then
    docker rm -vf $(docker ps -aq)
    STATUS=deploy docker-compose up

elif [[ $1 == "--clear" || $1 == "-c" ]]; then
    docker rm -vf $(docker ps -aq)
    docker system prune -a -f
    git remote prune origin

elif [[ $1 == "--rebuild" || $1 == "-r" ]]; then
    docker rm -vf $(docker ps -aq)
    docker system prune -a -f
    STATUS=development docker-compose up  --no-deps --build -V

elif [[ $1 == "--install" || $1 == "-i" ]]; then
    cd react && npm install --save
    cd ../express && npm install --save

elif [ -z "$1" ]; then
    STATUS=development docker-compose up

else
    if [[ $1 != "--help" && $1 != "-h" ]]; then
        echo ""
        echo "unknown shorthand flag: $1"
    fi
    echo ""
    echo "Usage: ./dev.sh [OPTIONS] [SERVICE] [PACKAGE]"
    echo ""
    echo "Options:"
    echo "  -h, --help             Show this help message"
    echo "  -d, --deploy           Deploy services (You need to have build folder in react before deploy.)"
    echo "                             ie: 'npm run build' in react to get the build folder"
    echo "  -c, --clear            Remove all containers and images, and prune remote git branches"
    echo "  -r, --rebuild          Rebuild all containers"
    echo "  -i, --install          Install packages for React and Express"
    echo ""
    echo "Service and package installation:"
    echo "  django  <package>       Install a Django package with pip and restart the Django container"
    echo "  react   <package>        Install an npm package for React"
    echo "  express <package>      Install an npm package for Express"
    echo ""
fi