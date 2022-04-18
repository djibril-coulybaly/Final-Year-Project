/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: map_marker.dart
  Description: This is the map marker model that we use to structure specific information about the map marker. 
               Each map marker will hold the follwing:
               - Stop ID
               - Name of Stop
               - Address of Stop
               - The latitude of the Stop
               - The longitude of the Stop
               - Operator Logo 1 (Main Logo that will be used if the stop is only run by one operator)
               - Operator Logo 2 (Only used if a stop has two operator running on that stop i.e. Dublin Bus and Go Ahead)
*/
class MapMarker {
  late String stopId;
  late String stopName;
  late String stopAddress;
  late double stopLat;
  late double stopLon;
  late String image;
  String image2 = "";

  MapMarker({
    required this.stopId,
    required this.stopName,
    required this.stopAddress,
    required this.stopLat,
    required this.stopLon,
    required this.image,
  });

  MapMarker.fromJson(Map<String, dynamic> json, String s) {
    stopId = json['stop_id'];
    stopName = json['stop_name'].toString().contains(", stop ")
        ? json['stop_name'].toString().split(', ')[0]
        : json['stop_name'];
    stopAddress = json['stop_name'].toString().contains(", stop ")
        ? json['stop_name'].toString().split(', ')[1]
        : json['stop_name'];
    stopLat = json['stop_lat'];
    stopLon = json['stop_lon'];
    image = s == "Dublin Bus"
        ? 'assets/dublinBusLogo.png'
        : s == "Go Ahead"
            ? 'assets/goAheadLogo.png'
            : s == "Iarnrod Eireann"
                ? 'assets/iarnrodEireannLogo.png'
                : s == "Luas"
                    ? 'assets/luasLogo.png'
                    : "";
  }
}
