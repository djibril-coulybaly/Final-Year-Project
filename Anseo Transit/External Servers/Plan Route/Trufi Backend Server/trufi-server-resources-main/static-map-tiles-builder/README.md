# Static Map Tiles Builder

| &nbsp;                                 | &nbsp;                                                       |
| -------------------------------------- | ------------------------------------------------------------ |
| The following extensions depend on it  | [static_maps](https://github.com/trufi-association/trufi-server/tree/main/extensions/static_maps) |
| This depends on the following builders | [mbtiles-builder](../mbtiles-builder)                        |

## Description

**Only use this if you have a server which has not enough power to run the alternative extension [tileserver](https://github.com/trufi-association/trufi-server/tree/main/extensions/tileserver) .**

Generates static `*.png` map background tiles by bulk querying the build-in OpenMapTiles service which can generate `*.png` files out of the `*.mbtile` input file. The static `*.png` files are needed by the fallback extension [static_maps](https://github.com/trufi-association/trufi-server/tree/main/extensions/static_maps) and is aimed at servers with less CPU power and RAM storage e.g. cheap servers.

For servers with much CPU power we recommend using the extension [tileserver](https://github.com/trufi-association/trufi-server/tree/main/extensions/tileserver) and its [MBTile Builder](../mbtiles-builder) to be more dynamic to changes of the map styles and to be able to individualize map styles.

## How to use

Just run the command and see the magic:

```bash
docker-compose --env-file ../$envfile -f ./docker-compose.yml up --build map_builder && docker-compose -f ./docker-compose.yml stop
```

- The static map tiles images will be located at `../data/<Country-City>/static_maps`
