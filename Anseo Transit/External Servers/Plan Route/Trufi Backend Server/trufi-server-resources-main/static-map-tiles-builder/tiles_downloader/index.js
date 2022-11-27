const Axios = require('axios')
const fs = require('fs')
const path = require('path')


const lonToX = (lon, zoom) => Math.floor((lon + 180) / 360 * Math.pow(2, zoom))

const latToY = (lat, zoom) => {
  const lat_rad = lat * Math.PI / 180
  return Math.floor((1 - Math.log(Math.tan(lat_rad) + 1 / Math.cos(lat_rad)) / Math.PI) / 2 * Math.pow(2, zoom))
}

const downloadImage = async (input) => {
  let { z, x, y, outPath, serverUrl, style, imageFormat } = input
  if (!fs.existsSync(outPath)) {
    fs.mkdirSync(outPath);
  }
  outPath = path.join(outPath, style)
  if (!fs.existsSync(outPath)) {
    fs.mkdirSync(outPath);
  }
  const zPath = path.join(outPath, `${z}`)
  if (!fs.existsSync(zPath)) {
    fs.mkdirSync(zPath);
  }

  const xPath = path.join(zPath, `${x}`)
  if (!fs.existsSync(xPath)) {
    fs.mkdirSync(xPath);
  }

  const filePath = path.join(xPath, `${y}${imageFormat}`)

  const writer = fs.createWriteStream(filePath)
  const url = `${serverUrl}/${style}/${z}/${x}/${y}${imageFormat}`
  const response = await Axios({
    url,
    method: 'GET',
    responseType: 'stream'
  })
  response.data.pipe(writer)

  return new Promise((resolve, reject) => {
    writer.on('finish', resolve)
    writer.on('error', reject)
  })
}
const tilesInBbox = async (bbox, zMax, styles, imageFormat) => {
  for (const style of styles) {

    console.log(`start: ${style}, ${(new Date()).toLocaleString()}`)
    let z = 1
    while (z <= zMax) {
      const xMin = lonToX(bbox.west, z)
      const xMax = lonToX(bbox.east, z)
      const yMin = latToY(bbox.north, z)
      const yMax = latToY(bbox.south, z)

      let x = xMin
      while (x <= xMax) {
        let y = yMin
        while (y <= yMax) {
          await downloadImage({
            z,
            x,
            y,
            outPath:
              path.join(__dirname, 'out'),
            serverUrl: "http://tileserver:8080/styles",
            style,
            imageFormat
          })
          y++
        }
        x++
      }
      console.log(`\t${z}: ${(new Date()).toLocaleString()}`)
      z++
    }
    console.log(`end: ${style}, ${(new Date()).toLocaleString()}`)
  }
}

const bbox = process.env.bbox.split(",").map(element=>Number(element))

tilesInBbox({
  west: bbox[0],
  south: bbox[1],
  east: bbox[2],
  north: bbox[3]
}, 18, ["trufi-liberty", "trufi-dark"], "@2x.jpg").catch(error => {
  console.log(error)
})
