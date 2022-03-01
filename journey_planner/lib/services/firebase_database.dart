import 'package:cloud_firestore/cloud_firestore.dart';

class FDB {
  /* Reference to the users collection in the firestore cloud database */
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  /* Reference to the ticket collection in the firestore cloud database */
  // DocumentReference ticketDocRef = FirebaseFirestore.instance.collection('ticket').doc();

  /* Reference to the travel card collection in the firestore cloud database */
  // final CollectionReference travelCardCollection = FirebaseFirestore.instance.collection('travel_card');

  final String uid;
  FDB({required this.uid});

  /* Function to add the additional information that we collected from the user and enter it into our firebase database */
  Future initUpdateUserData(
      String firstName,
      String lastName,
      String addressline1,
      String addressline2,
      String city,
      String county,
      String postcode,
      String phoneNumber) async {
    /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
    return await usersCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'address_line_1': addressline1,
      'address_line_2': addressline2,
      'city': city,
      'county': county,
      'postcode': postcode,
      'phone_number': phoneNumber
    });
  }

  /* Function to add the ticket information that we want to connect to the user account in the firebase database */
  // Future initUpdateUserTicket(
  //     bool activated,
  //     double amount,
  //     DateTime date,
  //     String transportOperator,
  //     double price,
  //     String route,
  //     String transactionID,
  //     String type) async {
  //   /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
  //   return await usersCollection.doc(uid).collection('ticket').add({
  //     'activated': activated,
  //     'amount': amount,
  //     'date': date,
  //     'operator': transportOperator,
  //     'price': price,
  //     'route': route,
  //     'transaction_id': transactionID,
  //     'type': type
  //   });
  // }

  /* Function to add the ticket information that we want to connect to the user account in the firebase database */
  Future initUserTicket(
      bool activated,
      double amount,
      DateTime date,
      String transportOperator,
      double price,
      String route,
      String transactionID,
      String type,
      DocumentReference<Map<String, dynamic>> ticketDoc) async {
    try {
      /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
      await ticketDoc.set({
        'activated': activated,
        'amount': amount,
        'date': date,
        'operator': transportOperator,
        'price': price,
        'route': route,
        'transaction_id': transactionID,
        'type': type
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /* Function to add the travel card information that we want to connect to the user account in the firebase database */
  Future initUpdateUserTravelCard(double balance, double busCap,
      double multiModeCap, double trainCap, double tramCap, String type) async {
    /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
    return await usersCollection.doc(uid).collection('travel_card').add({
      'balance': balance,
      'bus_cap': busCap,
      'multi_mode_cap': multiModeCap,
      'train_cap': trainCap,
      'tram_cap': tramCap,
      'type': type
    });
  }
}
