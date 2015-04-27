#!/bin/bash
# Start docker
echo 'Starting boot2docker...'
boot2docker up > /dev/null 2>&1

# Prepare the shell environment
echo 'Exporting shell environment variables...'
$(/usr/local/bin/boot2docker shellinit) > /dev/null 2>&1

# Stop all running docker containers (if any)
# This should really be filtered to just our container at some point.
echo 'Stopping any running containers...'
docker stop $(docker ps -a -q) > /dev/null 2>&1

# Forward port 4000 from boot2docker-vm to localhost
# I've not worked out how to do this selectively yet. 
# VBox will complain if the mapping already exists.
echo 'Forwarding port 4000 from boot2docker-vm...'
VBoxManage controlvm boot2docker-vm natpf1 "jekyll,tcp,127.0.0.1,4000,,4000" > /dev/null 2>&1 

# Run docker in the background on port 4000.
# This leaves Jekyll in the foreground of the terminal window.
# To background it instead, replace --rm with -d.
docker run --rm -v "$PWD:/src" -p 4000:4000 grahamc/jekyll serve --drafts --host 0.0.0.0 --watch