#!/bin/bash

echo "Provisioning machine..."

echo "Installing available updates..."
sudo apt-get update

echo "Installing build-essential, git and ruby1.9.3..."
sudo apt-get -y install build-essential git ruby1.9.3

echo "Compiling and installing node.js..."
cd /opt
wget http://nodejs.org/dist/v0.10.32/node-v0.10.32.tar.gz > /dev/null 2>&1
tar -zxvf node-v0.10.32.tar.gz > /dev/null 2>&1
cd node-v0.10.32

echo "Configure/Make..."
./configure > /dev/null 2>&1
make > /dev/null 2>&1

echo "Installing..."
make install

echo "Installing Jekyll..."
sudo gem install jekyll --no-ri --no-rdoc

echo "Installing github-pages gem..."
sudo gem install github-pages --no-ri --no-rdoc 

