cube-daemons
============

This repository will help you to install [cube](https://github.com/square/cube) on an Ubuntu/Debian machine.

It assumes you've already installed [node.js](http://nodejs.org/) and [npm](https://www.npmjs.org/) and that your node prefix is `/usr`.


## Install

Just clone the repository with `git clone git@github.com:lmammino/cube-daemons.git` then run `sudo cube-daemons/install.sh` and it will do all the **hard work** for you.

The hard work means:

 - Install cube as global package
 - Creates a dedicate `cube` user that will be used to run the daemons
 - Copies the daemons start/stop file
 - Starts the daemons


## TODOs

 [ ] Tests
 [ ] Allow to use a customized node prefix
 [ ] Allow to provide specific configuration for the daemons

## License

This code is distributed under the MIT license. Please refer to the [LICENSE](/LICENSE) file to read the full version.

Contributions are always (really) appreciated :wink: