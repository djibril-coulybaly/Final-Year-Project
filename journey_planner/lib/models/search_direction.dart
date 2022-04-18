/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: search_direction.dart
  Description: This is the search direction model that we use to structure specific information about the directions of a route. 
               Each search direction will hold the follwing:
               - Route ID
               - Name of inbound direction
               - Name of outbound direction
               - Direction ID
*/
class SearchDirection {
  late String routeId;
  late String inboundName;
  late String outboundName;
  late String directionID;

  SearchDirection({
    required this.routeId,
    required this.inboundName,
    required this.outboundName,
    required this.directionID,
  });

  SearchDirection.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'].toString();
    directionID = json['direction_id'].toString();

    if (directionID == "0") {
      inboundName = json['trip_headsign'].toString().split(' - ')[0];
      outboundName = json['trip_headsign'].toString().split(' - ')[1];
    } else {
      outboundName = json['trip_headsign'].toString().split(' - ')[0];
      inboundName = json['trip_headsign'].toString().split(' - ')[1];
    }
  }
}
