# Graph Data Builder

| &nbsp;                                 | &nbsp;                                                       |
| -------------------------------------- | ------------------------------------------------------------ |
| The following extensions depend on it  | [otp](https://github.com/trufi-association/trufi-server/tree/main/extensions/otp) |
| This depends on the following builders | [map-pbf-builder](../map-pbf-builder) (always), [gtfs-builder](../gtfs-builder) (only if you have no GTFS file already) |

## Description

Builds the graph needed by the routing engine [OpenTripPlanner](https://opentripplanner.org). This uses the [OpenTripPlanner](https://opentripplanner.org) itself to build the graph.

**If you did not use [gtfs-builder](../gtfs-builder)** then put the GTFS file you obtained from elsewhere in `../data/<Country-City>/otp/data` and name it `GTFS.zip` (the case does not matter). If you have more than just GTFS file then number then like `1_GTFS.zip`, `2_GTFS.zip` etc. or `regionA_GTFS.zip`, `regionB_GTFS.zip`

## How to use

```bash
sudo docker-compose --env-file ../$envfile up --build
```

- The `.obj` file out is located at `../data/<Country-City>/otp/data`
