const { osmToGtfs, OSMPBFReader, OSMOverpassDownloader } = require('trufi-gtfs-builder')
const path = require('path')
// -73.104656,5.755485,-72.9504,5.877577
osmToGtfs({
  outputFiles: { outputDir: __dirname + '/out', trufiTPData: true, gtfs: true },
  geojsonOptions: {
    osmDataGetter: new OSMPBFReader(path.join(__dirname, "city.osm.pbf")),
    // osmDataGetter: new OSMOverpassDownloader({
    //   west: -73.104656,
    //   south: 5.755485,
    //   east: -72.9504,
    //   north: 5.877577
    // }),
    skipRoute: (route) => {
      const routesToSkip = [13225141, 13217723, 13253160, 13260428]
      return routesToSkip.indexOf(route.id) === -1
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
