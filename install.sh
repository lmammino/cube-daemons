#!/bin/bash

#run as sudo

#install cube
echo "\n\n====\n1. Installing cube...\n====\n\n"
npm install --global cube

#create cube user and group
echo "\n\n====\n2. Creating cube user...\n====\n\n"
useradd -r -s /bin/false cube

#create cube run dir (for pid files)
echo "\n\n====\n3. Creating /var/run/cube folder...\n====\n\n"
mkdir -p /var/run/cube

#copying scripts
echo "\n\n====\n4. Copying start/stop scripts...\n====\n\n"
cp cube-collector /etc/init.d/cube-collector
cp cube-evaluator /etc/init.d/cube-evaluator
chmod +x /etc/init.d/cube-collector /etc/init.d/cube-evaluator

#running daemons
echo "\n\n====\n5. Starting daemons...\n====\n\n"
/etc/init.d/cube-collector start
/etc/init.d/cube-evaluator start

echo "\n\n Done.\n"