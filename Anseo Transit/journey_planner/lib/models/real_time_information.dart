/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: map_marker.dart
  Description: This is the real time information model that we use to structure specific information about the real time information. 
               Each real time information will hold the follwing:
               - Name of Route
               - Direction of Route
               - When is the route due to arrive at the stop
               - Logo of Operator 
*/
class RealTimeInformation {
  late String routeName;
  late String towards;
  late double due;
  late String operatorLogo;

  RealTimeInformation({
    required this.routeName,
    required this.towards,
    required this.due,
    required this.operatorLogo,
  });

  RealTimeInformation.fromJson(Map<String, dynamic> json) {
    routeName = json['route'].toString();
    towards = json['headsign'].toString().split(' - ')[1];
    due = json['dueInSeconds'];

    if (json['agencyName'].toString() == "978") {
      operatorLogo = 'assets/dublinBusLogo.png';
    } else if (json['agencyName'].toString() == "03") {
      operatorLogo = 'assets/goAheadLogo.png';
    } else if (json['agencyName'].toString() == "02") {
      operatorLogo = 'assets/iarnrodEireannLogo.png';
    } else if (json['agencyName'].toString() == "10000") {
      operatorLogo = 'assets/luasLogo.png';
    } else {
      operatorLogo = "";
    }
  }
}
