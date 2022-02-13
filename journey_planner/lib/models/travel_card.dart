/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  File Description: THis is the travel card model - firebase

*/

class TravelCard {
  TravelCard({
    required this.travelCardID,
    required this.balance,
    required this.busCap,
    required this.multiModeCap,
    required this.trainCap,
    required this.tramCap,
    required this.type,
  });

  final String travelCardID;
  final bool balance;
  final double busCap;
  final DateTime multiModeCap;
  final String trainCap;
  final double tramCap;
  final String type;
}
