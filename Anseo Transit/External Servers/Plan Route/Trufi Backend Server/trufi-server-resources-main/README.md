# Trufi Server Resources
**Resources generator for [Trufi-Server](https://github.com/trufi-association/trufi-server)**.

This repo contains all builders needed to create the resources which [trufi-server](https://github.com/trufi-association/trufi-server) needs, you only need to provide a `config` file inside the `./config` folder for most services. The *GTFS Builder* needs more and is an exception.

**We use docker but not to make this cross-platform. This is intended to be used on Linux. Mac will probably work but is untested. We use docker to make setups equal and easy for all users and their systems.**

## Requirements

- [Docker](https://www.docker.com/products/docker-desktop)
- docker-compose
- nodejs (deprecated, to remove)
- Config file

## Step for step tutorial

This assumes that you already met all the requirements.

### Config file

The config files are located inside `./config` folder, you can create a new one providing your own variables:
| variable | example | description |
| ------ | ------ | ------ |
| city | Bolivia-Cochabamba | Just `Country-City` name |
| bbox | -66.453088,-17.762296,-65.758056,-17.238372 | Just bound box of the city, you can get one [here](https://boundingbox.klokantech.com/) using `dublinCore type` |
| otpversion | 1.5.0 | Put there `1.5.0` for regions running informal transport otherwise `2.0.0` |
| geofabrik_url_path | /south-america/bolivia-latest.osm.pbf | You can get the `path` [here](https://download.geofabrik.de/) |

Create a new one based on the already existing config files to get an idea of their internal structure. Optionally but relevant for automation later on you can specify any variable giving it any name taking a semicolon separated list of builder names without any whitespaces included to be executed in order. See section [Automation](#automation) for more details on this.

### Preparing the terminal

After cloning you need to open a terminal pointing to this repository as the current working dir. We assume a terminal running Bash (on Linux or Mac) inside. We want to prepare it and do that with the following commands:

```bash
export envfile="./config/<city_env_file>"
```

Replace `<city_env_file>` with the name of the configuration file you created previously.

### Execute builders

Now execute the builders in the following order

1. [**Map PBF Data Builder**](./map-pbf-builder)
   Downloads an OSM extract from [Geofabrik](https://geofabrik.de) and extracts only the area needed by the community to get an even smaller pbf extract.
2. **[MBTiles Builder](./mbtiles-builder)**
   Generates the background map tiles in the `*.mbtiles` format used by many tile serving services like [OpenMapTiles](https://github.com/openmaptiles/openmaptiles) what we use for our extensions [tileserver](https://github.com/trufi-association/trufi-server/tree/main/extensions/tileserver) and as basis for [static_maps](https://github.com/trufi-association/trufi-server/tree/main/extensions/static_maps).
3. [**Static Map Tiles Builder**](./static-map-tiles-builder)
   Generates `*.png` map background tiles needed by the extension [static_maps](https://github.com/trufi-association/trufi-server/tree/main/extensions/static_maps) which is a fallback for servers with less CPU power and RAM e.g. cheap servers. *So only use this builder if you have such a server.*
4. **[GTFS Data Builder](./gtfs-builder)**
   Generates the GTFS needed to enable routing through public transportation routes.
   *If you obtained a GTFS from elsewhere e.g. from your authority then do not execute this builder but plot the GTFS file in `./data/<Country-City>/otp/data` in your [trufi-server-resources](https://github.com/trufi-association/trufi-server-resources) local copy before executing the next builder. Name the file `GTFS.zip`*
5. [**Graph Data Builder**](./graph-builder)
   Builds the graph needed by the routing engine [OpenTripPlanner](https://opentripplanner.org) which powers our extension [otp](https://github.com/trufi-association/trufi-server/tree/main/extensions/otp).
6. [**Photon Data Builder**](./photon-data-builder)
   Downloads & extracts the search index for your country needed to offer online search suggestions to the app.
   *Only use this builder if you want to use online search functionality and translation of coordinates into human friendly place names. Its use is recommended in places where mobile data usage do not matter in terms of pricing and availability.*

## The `data` folder contains the output

The `output` folder is `./data/<Country-City>`, where will be located all resources generated with this set of tools. 

Docker changed the permissions of the volumes and we don’t have the necessary rights anymore. We need to change that before we can copy the resources over to our [trufi-server](https://github.com/trufi-association/trufi-server) instance.

```bash
sudo chown -R $USER:$USER ./data
```

will do that for us.

If you use the `pipeline` script this will be done automatically at the end.

The contents there are now ready to be copied and merged into the `extensions` folder of your [trufi-server](https://github.com/trufi-association/trufi-server) instance.

## Resource Binding

We use a system we call "Resource Binding" to make merging files from `/trufi-server-resources/data/<Country-City>/` into `/trufi-server/extensions` really easy. It basically means:

> `./data/<Country-City/` in this repository is fileystem structure identical to the directory `./extensions` in the repo [trufi-server](https://github.com/trufi-association/trufi-server).

We consider something "fileystem structure identical" if the directory and subdirectory names of source and target are equal.

### Example A

We consider the following structure "filesystem structure identical" in `/trufi-server-resources/data/Bolivia-Cochabamba`

```bash
├── tileserver
├── photon
├── static_maps
└── otp
```

to the following structure in `/trufi-server/extensions` in the repo [trufi-server](https://github.com/trufi-association/trufi-server)

```bash
├── tileserver
├── photon
├── static_maps
└── otp
```

. So copying the contents in folder `/trufi-server-resources/data/Bolivia-Cochabamba` into `/trufi-server/extensions` would result in a merge creating the necessary structure and managing the necessary overwrites to make the extensions in repo `trufi-server` work (with updated data) you created using the toolset in repo `trufi-server-resources` (this one). This merge can be performed by a regular file manager.

### Example B

```bash
cp -a ./trufi-server-resources/data/Bolivia-Cochabamba/* ./trufi-server/extensions --verbose
```

## Automation

### Explanation

After you’ve run all builders manually and understand why the order is necessary as specified in [Execute builders](#execute-builders) because you understand the dependencies they have you can automate the building process in case you need to execute certain ones in order repeatedly to get fresh data into your backend.

You can automate the building process by editing your `<Country-City>.env` file and adding a variable. You can call it anything you like. The name does not matter. But by a convention which is still to develop it is recommended to prefix the name with `pipeline_`. The chosen name must be within the limitations exposed by Bash otherwise you will run into a parsing error which yields weird results. As its value the variable takes a semicolon separated list of builders to be executed in order. Whitespaces in that list are not allowed and will result into incomplete parsing. Each item of the list needs to correspondent to the name of the directory of the builder. If we want the [Map PBF Data Builder](./map-pbf-builder) to be executed we need to specify the name of its directory which is [map-pbf-builder](./map-pbf-builder).

### Example

**An example taken from `Germany-Hamburg.env`:**

```bash
pipeline_pbfgraphmbtiles=map-pbf-builder;graph-builder;mbtiles-builder
```

Here a variable with the name `pipeline_pbfgraphmbtiles` and the semicolon separated list `map-pbf-builder;graph-builder;mbtiles-builder` which tells the automation script to execute the builders in the following order:

1. `map-pbf-builder`
2. `graph-builder`
3. `mbtiles-builder`

The order given here needs to correspond with the order of execution as laid out by the dependencies each has. E.g. by looking at its [README](./mbtiles-builder/README.md) file we see that the builder `mbtiles-builder` has `map-pbf-builder` as its dependency. You need to call its dependencies before calling it. This is a general rule of thumb

> Call dependencies first, the builder second!

The same for `graph-builder`. Luckily it has also `map-pbf-builder` as its dependency so we don’t need to call it again because it has been called already in this round. This is a general rule of thumb

> Call a dependency only once in a round to not perform the same operation twice!

You might wonder about the second dependency `gtfs-builder` the `graph-builder` has. Since the city of Hamburg provides us a GTFS file we don’t need to create it ourselves.

### Executing a pipeline

Executing a pipeline is easy and just takes one command. It just automates what you would do manually. Don’t know what `[` and `]` then see [here](http://faculty.juniata.edu/rhodes/dbms/sqlddl.htm) :)

```bash
. pipeline <env file> <name of variable> [--dry-run] [--no-color]
```

With colors

```bash
. pipeline Germany-Hamburg pipeline_pbfgraphmbtiles
```

Without colors

```bash
. pipeline Germany-Hamburg pipeline_pbfgraphmbtiles --no-color
```

Only simulate execution of builders:

```bash
. pipeline Germany-Hamburg pipeline_pbfgraphmbtiles --dry-run
```

Redirect script output to a report file in Markdown format:

```bash
. pipeline Germany-Hamburg pipeline_pbfgraphmbtiles --no-color >report.md
```
