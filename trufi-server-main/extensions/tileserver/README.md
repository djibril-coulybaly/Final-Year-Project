# Extension `tileserver`

|                                        |                                                              |
| -------------------------------------- | ------------------------------------------------------------ |
| This depends on the following builders | [mbtiles-builder](https://github.com/trufi-association/trufi-server-resources/tree/main/mbtiles-builder) |

## Description

This extension is using [Tileserver-GL](https://github.com/maptiler/tileserver-gl) from [Maptiler](https://www.maptiler.com/). It generates png tiles dynamically by request and lets client also download the styles and data by themselves for client side rendering which is the future due to individualization efforts of world wide society and economy. <u>If you use clients that cannot render client side like apps build using the Trufi Core or Flutter in general then this service will be consuming more resources server side because it renders tiles per request.</u>

For servers with less CPU power e.g. cheap servers. we recommend using the alternative [static_maps](../static_maps)

The app needs this extension or the alternative to be able to display a background map to the user.

## How to set up

### Modifying the configuration

The bounding box is **<u>not strictly necessary for production</u>** but is helpful in order to verify everything is working. Feel free to choose option A or B. You can find the configuration in `./config/config.json`.

#### Option A: Using bounding box (recommended)

If you want a bounding box in order to debug properly then perform the following steps to get one:

1. Go to https://boundingbox.klokantech.com/
2. Head over to your region/town/city/commune
3. Draw a bounding box around your city or just use a part of it you know well.
4. At the left bottom there is a dropdown. Select "CSV"
5. Copy the content in the textfield next to the dropdown.
6. In the `config.json` replace the bounding box (value of `bound` ) with the coordinates you copied in the previous step.
7. Do that for every style.

#### Option B: Without defining a bounding box

In the `config.json`  remove all occurrence of key `tilejson` and its values otherwise you render your instance of OpenMapTiles unusuable.

### Test the configuration

Do `sudo docker-compose start tileserver` and head over to your webbrowser to type in the ip/url of your server and open a HTTP connection on port `8002` e.g. `http://example.com/tileserver:8002` or `http://localhost:8002`.

Watch out if you can click on "inspect" and then you should see a map of your chosen region.
