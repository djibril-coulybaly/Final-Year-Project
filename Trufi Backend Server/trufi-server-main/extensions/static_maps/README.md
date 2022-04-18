# Extension `static_maps`

|                                         |                                                              |
| --------------------------------------- | ------------------------------------------------------------ |
| This depends on the following builders: | [static-map-tiles-builder](https://github.com/trufi-association/trufi-server-resources/tree/main/static-map-tiles-builder) |

## Description

This extension is a fallback for servers with less CPU power and RAM e.g. cheap servers. This serves static map background tiles as bunch of `*.png` as you know it from [OpenStreetMap](https://openstreetmap.org) and therefore requires few CPU power. But depending on the amount of hectars the region you want to serve has as more disk space is required.

For servers with much CPU power we recommend using the alternative [tileserver](../tileserver) to be more dynamic to changes to the underlying map data and the different map styles.

The app needs this extension or its alternative to be able to display a background map to the user.
