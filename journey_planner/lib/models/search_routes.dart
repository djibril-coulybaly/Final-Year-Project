/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: search_direction.dart
  Description: This is the search route model that we use to structure specific information about the a route when searching. 
               Each search route will hold the follwing:
               - Route ID
               - Name of route
               - Name of Operator
               - Operator Logo
*/
class SearchRoute {
  late String routeId;
  late String routeName;
  late String operatorName;
  late String operatorLogo;

  SearchRoute({
    required this.routeId,
    required this.routeName,
    required this.operatorName,
    required this.operatorLogo,
  });

  SearchRoute.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'].toString();

    if (json['route_short_name'].toString() == "") {
      routeName = json['route_long_name'].toString();
    } else {
      routeName = json['route_short_name'].toString();
    }

    if (json['agency_id'].toString() == "978") {
      operatorName = 'Dublin Bus';
    } else if (json['agency_id'].toString() == "03") {
      operatorName = 'Go Ahead';
    } else if (json['agency_id'].toString() == "02") {
      operatorName = 'Iarnrod Eireann';
    } else if (json['agency_id'].toString() == "10000") {
      operatorName = 'Luas';
    } else {
      operatorName = "";
    }

    if (json['agency_id'].toString() == "978") {
      operatorLogo = 'assets/dublinBusLogo.png';
    } else if (json['agency_id'].toString() == "03") {
      operatorLogo = 'assets/goAheadLogo.png';
    } else if (json['agency_id'].toString() == "02") {
      operatorLogo = 'assets/iarnrodEireannLogo.png';
    } else if (json['agency_id'].toString() == "10000") {
      operatorLogo = 'assets/luasLogo.png';
    } else {
      operatorLogo = "";
    }
  }
}
