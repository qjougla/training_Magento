#!/usr/bin/env bash

#
# Don't run as root
#
if [ "$EUID" == 0 ]; then
    echo -e "Please do not run this script as root"
    exit 1
fi

#
# Check Docker
#
if command -v docker >/dev/null 2>&1 ; then
    echo "OK, Docker is installed"
else
    echo "ERROR: docker not found"
    echo "Please install latest version from docker.com: https://docs.docker.com/get-docker/"
    exit 1
fi

#
# Check user in docker group
#
if [ "$(uname)" == "Linux" ]; then
    if id -Gnz $USER | sed 's/\x0/\n/g' | grep '^docker$' > /dev/null; then
        echo "OK, user $USER exists in docker group"
    else
        echo -e "ERROR: Please add your user $USER to docker group AND reboot : https://docs.docker.com/engine/install/linux-postinstall/\n"
        exit 1
    fi
fi

#
# Stop all docker containers
#
#if [ -n "$(docker ps -q)" ]; then
#    echo -e "\nPlease stop all docker containers and retry\n"
#    echo -e "To stop all containers, run: docker stop \$(docker ps -aq)"
#    exit 1
#fi

#
# Check Make
#
if command -v make >/dev/null 2>&1 ; then
    echo "OK, Make is installed"
else
    echo "ERROR: make not found !"
    echo "Please install make"
    exit 1
fi

#
# Check Docker-Compose
#
if command -v docker-compose >/dev/null 2>&1 ; then
    echo "OK, Docker Compose is installed"
else
    echo "ERROR: docker-compose not found !"
    echo "Please install latest version from docker.com: https://docs.docker.com/compose/install/"
    exit 1
fi

echo
echo "Perfect: all requirements are satisfied. You can continue the install process :)"