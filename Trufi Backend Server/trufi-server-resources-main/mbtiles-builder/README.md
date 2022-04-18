# MBTiles Builder

| &nbsp;                                 | &nbsp;                                                       |
| -------------------------------------- | ------------------------------------------------------------ |
| The following extensions depend on it  | [tileserver](https://github.com/trufi-association/trufi-server/tree/main/extensions/tileserver) |
| This depends on the following builders | [map-pbf-builder](../map-pbf-builder)                        |

## Description

Generates the background map tiles in the `*.mbtile` format used by many tile serving services like [OpenMapTiles](https://github.com/openmaptiles/openmaptiles) what we use for our extension [tileserver](https://github.com/trufi-association/trufi-server/tree/main/extensions/tileserver). Maps generated using this builder need to credit `© OpenMapTiles © OpenStreetMap contributors`. Attribution won't be applied automatically. This builder uses [OpenMapTiles](https://github.com/openmaptiles/openmaptiles) underneath.

## How to use

This tool will generate a `.mbtile` file which contains the necessary data for generating map background tiles either on the fly (upon request by the client) or static using the builder [*Static Map Tiles Builder*](./static-map-tiles-builder). Run the following commands:

```bash
export $(cat ../$envfile | xargs)
bash generate_mbtiles.sh
```

- The `.mbtile` file out is located at `../data/<Country-City>/tileserver/region/`
