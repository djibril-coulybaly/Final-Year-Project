const { osmToGtfs, OSMPBFReader, OSMOverpassDownloader } = require('trufi-gtfs-builder')
const path = require('path')
// -66.453088,-17.762296,-65.758056,-17.238372
osmToGtfs({
    outputFiles: { outputDir: __dirname + '/out', trufiTPData: true, gtfs: true },
    geojsonOptions: {
        // osmDataGetter: new OSMPBFReader(path.join(__dirname, "Bolivia-Cochabamba.osm.pbf")),
        osmDataGetter: new OSMOverpassDownloader({
            west: -66.453088,
            south: -17.762296,
            east: -65.758056,
            north: -17.238372
        }),
        skipRoute: (route) => {
            return route.id !== 2084702
        }
    },
    gtfsOptions: {
        stopNameBuilder: stops => {
            if (!stops || stops.length == 0) {
                stops = ['innominada']
            }
            return stops.join(' y ')
        },
    }
}).catch(error => console.error(error))