# GTFS Data Builder

| &nbsp;                                 | &nbsp;                                                       |
| -------------------------------------- | ------------------------------------------------------------ |
| The following extensions depend on it  | [otp](https://github.com/trufi-association/trufi-server/tree/main/extensions/otp) (only if no GTFS has been obtained by another means) |
| This depends on the following builders | [map-pbf-builder](../map-pbf-builder)                        |



## Description

**This builder is only needed if you cannot obtain a GTFS by another means e.g. your authority does not provide a GTFS.**

**If you don't need this builder** you just need to plot the GTFS file you've obtained in `./data/<Country-City>/otp/data` in your [trufi-server](https://github.com/trufi-association/trufi-server) instance.

Generates the GTFS needed to enable routing through public transportation routes. This is probably because your city is running informal public transport and as such there are no timetables and probably no fixed bus stops. In that case it makes no sense to generate a GTFS file because GTFS mainly contains the timetable in a machine readable format. But [OpenTripPlanner](https://opentripplanner.org) which we use as needs a GTFS file to make routing through public transportation work so we make use of some tricks to build a GTFS by creating a virtual timetable so OTP sees a public transportation vehicle passing by e.g. every five minutes.

## How to use

**TODO:** Dockerize

This step is more complex, and it is not possible to automated because each city needs it own config, you need create your own script inside `./gtfs-builder/cities` using the other cities as an example.
You may need to install all dependencies what the `gtfs builder` needs`(if not yet installed before)`, running the next command:

```sh
cd ./gtfs-builder && npm install && cd ..
```

once you already have installed the dependencies, you need to run the next command:

```sh
node ./gtfs-builder/cities/<Country-City>/
```

- The **gtfs data** will located on `gtfs-builder/cities/<Country-City>/out/gtfs`
- You need to copy and paste manually the `GTFS` folder into `data/<Country-City>/otp` to complete this step

> for more info about `gtfs builder` see the project [here](https://github.com/trufi-association/trufi-gtfs-builder)
