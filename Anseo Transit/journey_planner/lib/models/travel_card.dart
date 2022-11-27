/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: travel_card.dart
  Description: This is the travel card model that we use to structure specific information about the travel card.
               It has the same structure that is implented in the firebase database. Each travel card in a 
               users account will hold the follwing:
               - ID
               - Balance
               - Bus Cap
               - Multi Mode Cap
               - Train Cap
               - Tram Cap
               - Travel Card Type
*/

class TravelCard {
  TravelCard(
      //   {
      //   required this.travelCardID,
      //   required this.balance,
      //   required this.busCap,
      //   required this.multiModeCap,
      //   required this.trainCap,
      //   required this.tramCap,
      //   required this.type,
      // }
      );

  // final String travelCardID;
  // final bool balance;
  // final double busCap;
  // final DateTime multiModeCap;
  // final String trainCap;
  // final double tramCap;
  // final String type;

  String? travelCardID;
  double? balance;
  double? busCap;
  double? multiModeCap;
  double? trainCap;
  double? tramCap;
  String? type;

  Map<String, dynamic> toJson() => {
        'travel_card_id': travelCardID,
        'balance': balance,
        'bus_cap': busCap,
        'multi_mode_cap': multiModeCap,
        'train_cap': trainCap,
        'tram_cap': tramCap,
        'type': type,
      };

  TravelCard.fromSnapshot(snapshot)
      : travelCardID = snapshot.id,
        balance = snapshot.data()['balance'].toDouble(),
        busCap = snapshot.data()['bus_cap'].toDouble(),
        multiModeCap = snapshot.data()['multi_mode_cap'].toDouble(),
        trainCap = snapshot.data()['train_cap'].toDouble(),
        tramCap = snapshot.data()['tram_cap'].toDouble(),
        type = snapshot.data()['type'];
}
