const { osmToGtfs, OSMOverpassDownloader } = require('trufi-gtfs-builder')
// -0.467963,5.488591,0.036037,5.833565
osmToGtfs({
  outputFiles: { outputDir: __dirname + '/out' },
  geojsonOptions: {
    osmDataGetter: new OSMOverpassDownloader({
      west: -0.467963,
      south: 5.488591,
      east: 0.036037,
      north: 5.833565
    })
  },
  gtfsOptions: {
    stopNameBuilder: stops => {
      if (!stops || stops.length == 0) {
        stops = ['innominada']
      }
      return stops.join(' y ')
    }
  }
}).catch(error => console.error(error))
