# Map PBF Data Builder

| &nbsp;                                 | &nbsp; |
| -------------------------------------- | ------ |
| The following extensions depend on it  |        |
| This depends on the following builders |        |

## Description

Downloads an OSM extract from [Geofabrik](https://geofabrik.de) and extracts only the area needed by the community to get an even smaller pbf extract. The area to extract is specified using a bounding box in the chosen `*.env` file in `../config`.

## How to use

This tool will download and extract the `.pbf` file:

```bash
docker-compose --env-file ../$envfile -f docker-compose.yml up
```

- The `.pbf` file out is located at `../data/<Country-City>/otp/data`
