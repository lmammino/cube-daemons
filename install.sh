#!/bin/bash

#should be run as sudo

SOURCE=$(dirname ${BASH_SOURCE[0]})

#install cube
cat << EOF

------------------
1. Installing cube
------------------

EOF
npm install --global cube

#create cube user and group
cat << EOF

---------------------
2. Creating cube user
---------------------

EOF
useradd -r -s /bin/false cube

#create cube run dir (for pid files)
cat << EOF

--------------------------------
3. Creating /var/run/cube folder
--------------------------------

EOF
mkdir -p /var/run/cube

#copying scripts
cat << EOF

-----------------------------
4. Copying start/stop scripts
-----------------------------

EOF
cp $SOURCE/cube-collector /etc/init.d/cube-collector
cp $SOURCE/cube-evaluator /etc/init.d/cube-evaluator
chmod +x /etc/init.d/cube-collector /etc/init.d/cube-evaluator

#running daemons
cat << EOF

------------------
5. Running daemons
------------------

EOF
/etc/init.d/cube-collector start
/etc/init.d/cube-evaluator start


cat << EOF

Done.

EOF