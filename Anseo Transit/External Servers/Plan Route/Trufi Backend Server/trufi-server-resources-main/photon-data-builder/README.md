# Photon Data Builder

| &nbsp;                                 | &nbsp;                                                       |
| -------------------------------------- | ------------------------------------------------------------ |
| The following extensions depend on it  | [photon](https://github.com/trufi-association/trufi-server/tree/main/extensions/photon) |
| This depends on the following builders |                                                              |

## Description

**Only use this builder if you want to use online search functionality and translation of coordinates into human friendly place names. Its use is recommended in places where mobile data usage do not matter in terms of pricing and availability.**

Downloads & extracts the search index for your country needed by the extension [photon](https://github.com/trufi-association/trufi-server/tree/main/extensions/photon) to offer online search suggestions and for the functionality to translate from location coordinates to human friendly place names. Using this is not a must but strongly recommended in places where mobile data usage does not matter in terms of pricing and availability. Not using this builder and the extension which depends on it means that you need to do a POI data import and bundle that in the app. That also means that you need to release a new version of the app in case you want to update the POI extract.

## How to use

```bash
docker-compose --env-file ../$envfile up
```

- The search index out is located at `../data/<Country-City>/photon/data`
