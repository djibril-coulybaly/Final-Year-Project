/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: search_stop.dart
  Description: This is the search stop model that we use to structure specific information about the a stop when searching. 
               Each stop will hold the follwing:
               - Stop ID
               - Name of Stop
               - Number of Stop
               - Operator Logo 1 (Main Logo that will be used if the stop is only run by one operator)
               - Operator Logo 2 (Only used if a stop has two operator running on that stop i.e. Dublin Bus and Go Ahead)
*/
class SearchStop {
  late String stopID;
  late String stopName;
  late String stopNumber;
  late String operatorLogo1;
  String operatorLogo2 = "";

  SearchStop({
    required this.stopID,
    required this.stopName,
    required this.stopNumber,
    required this.operatorLogo1,
    // this.operatorLogo2,
  });

  SearchStop.fromJson(
    Map<String, dynamic> json,
    String s,
    // Map<String, dynamic> secondjson, bool isDublinBus, bool isGoAhead
  ) {
    stopID = json['stop_id'].toString();

    stopName = json['stop_name'].toString().contains(", stop ")
        ? json['stop_name'].toString().split(', stop ')[0]
        : json['stop_name'].toString();

    stopNumber = json['stop_name'].toString().contains(", stop ")
        ? json['stop_name'].toString().split(', stop ')[1]
        : json['stop_name'].toString();

    operatorLogo1 = s == "Dublin Bus"
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
