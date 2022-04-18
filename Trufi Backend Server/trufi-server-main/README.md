# trufi-server

A repository as a recipe to create your own production backend environment which powers your very own version of Trufi App. This only contains the services which actually **consume & serve but <u>do not create</u>**

- the search index (consumed by extension `photon`)
- the mbtile (map tiles for your region) (consumed by extension `tileserver`)
- the static png tiles for your region) (consumed by extension `static_maps`)
- the routing graph (consumed by extension `otp` - **O**pen**T**rip**P**lanner )

and of course Nginx which combines these extensions to one service to make them appear as *one* with *one* HTTPS certificate, web identity and url scheme.

If you actually need to create the stuff e.g. the mbtiles or the graph you better go to [Trufi Server Resources](https://github.com/trufi-association/trufi-server-resources).

**We use docker but not to make this cross-platform. This is intended to be used on Linux. We only use docker to make setups equal, easy for all admins and their systems, for security and troubleshooting concerns.**

## Concept

This repository contains a bunch of service „extensions“ rather than just one big service containing everything. This allows a community to just run what they need using nginx as web proxy. Each "extension" has a specified job and contains a README.

## Extensions

You can find all in the [extensions](./extensions) folder. Each extension has a README file with more detailed info.

- **[otp](./extensions/otp)**
  This is [OpenTripPlanner](https://opentripplanner.org) used to calculate the best route for the user of the app. *This service is mandatory for the app to work.*
- **[photon](./extensions/photon)**
  This is [Photon by Komoot](https://photon.komoot.io) used to provide online search results inside the app when the user searches for a POI to navigate from or to using public transportation. *This service is optional and but in case you **don't** use it you need to build the search index on the frontend site and only @SamuelRioTz knows how that works.*
- **[static_maps](./extensions/static_maps)**
  Use this service to serve pre-generated background map tiles. *This use of the service is optional but we recommend it if you have a server which is less in resources.*
- **[tileserver](./extensions/tileserver)**
  Use this service to serve the data needed to display the background map shown in the app. This does not include the styling (e.g. a highways are yellow lines and the water blue). The styling is done on the client side.  This allows you/us to make modifications to the stylings without the need to rerender all pngs of the background map for your city. It generates the png background map tiles on the fly for clients which do not support dynamic map tiles. *This use of the service is optional and cause much CPU usage when it needs to generate background maps on the fly (this is a wrong usage of this service). Our app currently does not support client side rendering of background maps so we only recommend using this service on a server with much CPU resources.*

Concerning background map tiles: Decide wethever you want to use the extension *static_maps* or *tileserver*. Using both is useless.

## Setup & Maintenance

### Copying things over

Definitely you used our tools in the [Trufi Server Resources](https://github.com/trufi-server-resources) you generate all the data you need for the backend tools here. Excellent because the structure there is to 100% compactible to this one and you don't need to figure out how to copy/move things over to here. See also the concept of [Resource Binding](https://github.com/trufi-association/trufi-server-resources#main-output-folder) we introduced. But anyway now come the smart people to play and you can be one of them.

To copy over the files to their appropriate location here you just need to do the following: In your very own copy of [Trufi Server Resources](https://github.com/trufi-server-resources) go to its `data` directory and copy the content of the `<Country-City>` which holds your data. Paste them into the `extensions` folder of this one and accept the merge with already existing data. Or to put it into the words/world of sysadmins just execute

```bash
cp -a ./trufi-server-resources/data/<Country-City>/* ./trufi-server/extensions --verbose
```

### Development environment

Run `init.dev` to initiate development mode

In a development environment you don’t need `journald` which is a logging system on Linux. This is exspecially the case if you’re using Windows or Mac because such an entry makes the docker-composes unsuable on these operating systems.

```yml
    logging:
      driver: "journald"
      options:
        tag: "{{.Name}}"
```

like

```yml
#    logging:
#      driver: "journald"
#      options:
#        tag: "{{.Name}}"
```

### Production environment

We hide all (optional) services behind a nginx proxy which also handles the encryption for them. To make encrypted connections to that nginx proxy possible we need to issue a HTTP certificate. Luckily there is *Let’s Encrypt* issuing them to anyone without the need to pay. Initialization is to be done using `init.prod` 

### Commands

After executing one of the init scripts you can work with the extensions. See [how to run scripts on linux](https://www.cyberciti.biz/faq/howto-run-a-script-in-linux/).

#### Extension management

- **To add an extension to the run configuration**
  - Command: `add_extension <extension name>` 
  - Example: `add_extension otp`
- **To remove an extension from the run configuration**
  - Command: `remove_extension <extension name>` 
  - Example: `remove_extension otp`
- **To (re)start an extension (just use when the extension hangs or other unusual things happened)**
  - Command: `restart_extension <extension name>`
  - Example: `restart_extension otp`

#### Server management (all added extensions + web server)

- **To start the server for the first time**
  - Command: `server run` or `server up`
- **To start the server**
  - Command: `server start`
- **To (re)start the server**
  - Command: `server restart`
- **To stop the server**
  - Command: `server stop`
- **To view a list of running extensions**
  - Command: `server ls` (filtered Trufi optimised result for `docker container ls --all` command)
  - Command: `server ps` (native docker-compose command for every single extension)
- **(production only) View logs for an extension from current day**
  - Command: `server log <extension name>`
  - Command: `server viewlog <extension name>`
  - Command: `viewlog <extension name>`
  - Example: `viewlog otp`
- **(production only) View logs for an extension with custom commands to the underlying `journalctl` command**
  - Command: `server log <extension name> <journalctl argument> [<journalctl argument>]`
  - Command: `server viewlog <extension name> <journalctl argument> [<journalctl argument>]`
  - Command: `viewlog <extension name> <journalctl argument> [<journalctl argument>]`

**Not all available commands are listed here e.g. most commands for `server` are documented in its source code or indirectly by `docker-compose`**

#### After upgrade

When we changed something on the repo and you pulled the new changes do the following:

```bash
./server down # to stop all added extensions + the web server and to remove them but not their images
./server build # to rebuild all added extensions + the web server and their images (overwriting the already existing ones)
./server start # to start all added extensions + the web server
```

