#!/bin/bash

#should be run as sudo
if [ "$UID" -ne 0 ]
  then echo "WARNING: it seems that the uninstaller has not be run as root. It may not work as intended."
  exit
fi


# stopping daemons
cat << EOF

-------------------
1. Stopping daemons
-------------------

EOF
/etc/init.d/cube-collector stop
/etc/init.d/cube-evaluator stop


#removing scripts
cat << EOF

------------------------------
2. Removing start/stop scripts
------------------------------

EOF
rm /etc/init.d/cube-collector
rm /etc/init.d/cube-evaluator
update-rc.d cube-collector remove
update-rc.d cube-evaluator remove


#removing cube run dir (for pid files)
cat << EOF

--------------------------------
3. Removing /var/run/cube folder
--------------------------------

EOF
rm -rf /var/run/cube


#Removing cube user and group
cat << EOF

---------------------
4. Removing cube user
---------------------

EOF
userdel cube
groupdel cube


#Uninstall cube
cat << EOF

-----------------
4. Uninstall cube
-----------------

EOF
npm uninstall -g cube


# Exit
cat << EOF

Done.

EOF
exit 0