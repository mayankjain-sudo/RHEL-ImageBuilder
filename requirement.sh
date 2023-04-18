#!/bin/bash
echo "Installing the requirement"

dnf install osbuild-composer composer-cli cockpit-composer bash-completion

echo "Enabling the services"
systemctl enable --now osbuild-composer.socket
systemctl enable --now cockpit.socket

echo "Creating a directory where you want to store your repository overrides"

mkdir -p /tmp/etc/osbuild-composer/repositories

echo "Coping the repo"

#cp /usr/share/osbuild-composer/repositories/rhel-87.json /etc/osbuild-composer/repositories/
cp /usr/share/osbuild-composer/repositories/rhel-87.json /tmp/etc/osbuild-composer/repositories

echo "restart service"

sudo systemctl restart osbuild-composer.service