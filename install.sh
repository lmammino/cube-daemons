#!/bin/bash


#variables
VERSION="1.0.3"
SOURCE=$(dirname ${BASH_SOURCE[0]})
TEMPLATES="$SOURCE/templates";
SHOW_HELP=false
INSTALL_CUBE=true
DEFAULT_NODE_PREFIX="/usr"
NODE_PREFIX=$DEFAULT_NODE_PREFIX
DEFAULT_COLLECTOR_CONFIG="$SOURCE/config/collector-config.js"
COLLECTOR_CONFIG=$DEFAULT_COLLECTOR_CONFIG
DEFAULT_EVALUATOR_CONFIG="$SOURCE/config/evaluator-config.js"
EVALUATOR_CONFIG=$DEFAULT_EVALUATOR_CONFIG


#parse options
for i in "$@"
do
	case $i in
		-h|--help)
			SHOW_HELP=true
		;;

		-n|--no-cube)
			INSTALL_CUBE=false
		;;

	    -p=*|--node-prefix=*)
	    	NODE_PREFIX="${i#*=}"
	    ;;

	    -c=*|--collector-config=*)
			COLLECTOR_CONFIG="${i#*=}"
		;;

		-e=*|--evaluator-config=*)
			EVALUATOR_CONFIG="${i#*=}"
		;;
	esac
done

# display help
if [ "$SHOW_HELP" = true ]; then
	cat << EOF

 Cube-daemons installer v${VERSION} by Luciano Mammino
 https://github.com/lmammino/cube-daemons

 Usage:

	sudo ./installer.sh [-h|--help] [-n|--no-cube] [-p|--node-prefix=PREFIX] [-c|--collector-config=COLLECTOR_CONFIG] [-e|--evaluator-config=EVALUATOR_CONFIG]

 options:

	-h|--help 			Display this help
	-n|--no-cube 			Avoid installing cube (useful if you already installed it)
	-p|--node-prefix=VALUE 		specify a custom node prefix (default "${DEFAULT_NODE_PREFIX}")
	-c|--collector-config=VALUE 	specify a custom config file for the collector (default "${DEFAULT_COLLECTOR_CONFIG}")
	-e|--evaluator-config=VALUE 	specify a custom config file for the evaluator (default "${DEFAULT_EVALUATOR_CONFIG}")

EOF

	exit 0;
fi


# Banner
cat << EOF
	            _           
	  ___ _   _| |__   ___ 
	 / __| | | |  _ \ / _ \ 
	| (__| |_| | |_) |  __/ 
	 \___|\__,_|_.__/ \___| 

    Cube-daemons installer v${VERSION} by Luciano Mammino
    https://github.com/lmammino/cube-daemons

EOF


#should be run as sudo
if [ "$UID" -ne 0 ]; then
	echo "WARNING: it seems that the installer has not be run as root. It may not work as intended."
fi


#install cube
if [ "$INSTALL_CUBE" = true ]; then
cat << EOF

---------------
Installing cube
---------------

EOF
npm install --global lmammino/cube
fi


#create cube user and group
cat << EOF

------------------
Creating cube user
------------------

EOF
useradd -r -s /bin/false cube


#create cube run dir (for pid files)
cat << EOF

-----------------------------
Creating /var/run/cube folder
-----------------------------

EOF
mkdir -p /var/run/cube


#copying configuration
if [ "$INSTALL_CUBE" = true ]; then
cat << EOF

--------------------
Copying config files
--------------------

EOF
mv $NODE_PREFIX/lib/node_modules/cube/bin/collector-config.js $NODE_PREFIX/lib/node_modules/cube/bin/collector-config.js.original
mv $NODE_PREFIX/lib/node_modules/cube/bin/evaluator-config.js $NODE_PREFIX/lib/node_modules/cube/bin/evaluator-config.js.original
cp $COLLECTOR_CONFIG $NODE_PREFIX/lib/node_modules/cube/bin/collector-config.js
cp $EVALUATOR_CONFIG $NODE_PREFIX/lib/node_modules/cube/bin/evaluator-config.js
fi


#copying scripts
cat << EOF

--------------------------
Copying start/stop scripts
--------------------------

EOF
sed -e "s;%NODE_PREFIX%;$NODE_PREFIX;g" $TEMPLATES/cube-collector > /etc/init.d/cube-collector
sed -e "s;%NODE_PREFIX%;$NODE_PREFIX;g" $TEMPLATES/cube-evaluator > /etc/init.d/cube-evaluator
chmod +x /etc/init.d/cube-collector /etc/init.d/cube-evaluator
update-rc.d cube-collector defaults
update-rc.d cube-evaluator defaults


#running daemons
cat << EOF

---------------
Running daemons
---------------

EOF
/etc/init.d/cube-collector start
/etc/init.d/cube-evaluator start


# Exit
cat << EOF

Done.

EOF
exit 0
