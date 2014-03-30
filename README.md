cube-daemons
============

This repository will help you to install/uninstall [cube](https://github.com/square/cube) as a system service on an Ubuntu/Debian machine.

By using this installer you will be able to start/stop the cube collector and the cube evaluator as services:

```bash
sudo service cube-collector start|stop|restart
sudo service cube-evaluator start|stop|restart
```


## Install

The installer assumes you've already installed [node.js](http://nodejs.org/), [npm](https://www.npmjs.org/) and [mongo](https://www.mongodb.org/) and that your node prefix is `/usr` (however you can specify a different one if needed).

Just clone the repository with 

```bash
git clone https://github.com/lmammino/cube-daemons.git
```

Then run 

```bash
sudo cube-daemons/install.sh
```

and it will do all the **hard work** for you.

The hard work means:

 - Install cube as global package
 - Creates a dedicate `cube` user that will be used to run the daemons
 - Copies configuration files
 - Copies the daemons start/stop file
 - Adds daemons as auto-starting services
 - Starts the daemons


You can customize the installation process by passing few options to the install script:

 - `-h` or `--help`: Display the help
 - `-n` or `--no-cube`: Avoid installing cube (useful if you already installed it)
 - `-p` or `--node-prefix=VALUE`: specify a custom node prefix (default "${DEFAULT_NODE_PREFIX}")
 - `-c` or `--collector-config=VALUE`: specify a custom config file for the collector (default "${DEFAULT_COLLECTOR_CONFIG}")
 - `-e` or `--evaluator-config=VALUE`: specify a custom config file for the evaluator (default "${DEFAULT_EVALUATOR_CONFIG}")


## Custom configuration files

By default the installer will copy the configuration files from the [config](/config) folder. If needed to provide different configuration files, you can customize them befor launching the installer or provide custom configuration files by using the `--collector-config` and `--evaluator-config` options.

Note that the files will not be copied if you use the `--no-cube` option.

## Uninstall

Just run

```bash
sudo cube-daemons/uninstall.sh
```

To clean up everything that has been installed previously


## License

This code is distributed under the MIT license. Please refer to the [LICENSE](/LICENSE) file to read the full version.

Contributions are always (and really) appreciated :wink: