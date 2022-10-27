/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: firebase_database.dart
  File Description: Functions used to provide transactional queries with Firebase
*/

// Imports utilised in this file
import 'package:cloud_firestore/cloud_firestore.dart';

class FDB {
  /* Reference to the users collection in the firestore cloud database */
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  /* Reference to the drivers collection in the firestore cloud database */
  final CollectionReference driversCollection =
      FirebaseFirestore.instance.collection('drivers');

  // final String uid;
  // final String ticketOrTravelCard;
  // final String docID;
  // FDB(
  //     {required this.uid,
  //     required this.ticketOrTravelCard,
  //     required this.docID});

  /* Function to add the additional information that we collected from the user and enter it into our firebase database */
  Future initDriverData(
    String firstName,
    String lastName,
    String operatorName,
    String uid,
    String email,
  ) async {
    /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
    return await driversCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'operator': operatorName,
      'email': email,
    });
  }

  /* Function to add the additional information that we collected from the user and enter it into our firebase database */
  Future getDriverData(String uid) async {
    /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
    return await driversCollection.doc(uid).get();
  }

  /* Function to update the travel card balance that is connected to the user account in the firebase database */
  Future addTransactionToUserTravelCard(
      String? uid,
      String? travelCardDoc,
      double? amount,
      String? selectedOperator,
      selectedRoute,
      DateTime? date) async {
    try {
      await usersCollection
          .doc(uid)
          .collection('travel_card')
          .doc(travelCardDoc)
          .collection("transactions")
          .add({
        'amount': amount,
        'date': date,
        'operator': selectedOperator,
        'route': selectedRoute,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /* Function to update the travel card balance that is connected to the user account in the firebase database */
  Future updateCappingUserTravelCard(String? uid, String? travelCardDoc,
      double amount, String? selectedOperator, String selectedRoute) async {
    try {
      // Get the most recent data from the travel card via firebase query
      DocumentSnapshot travelcardQuery = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('travel_card')
          .doc(travelCardDoc)
          .get();
      var travelCardBalance = travelcardQuery['balance'];
      var travelCardBusCap = travelcardQuery['bus_cap'];
      var travelCardMultiModeCap = travelcardQuery['multi_mode_cap'];
      var travelCardTrainCap = travelcardQuery['train_cap'];
      var travelCardTramCap = travelcardQuery['tram_cap'];

      // var travelCardModel = TravelCard.fromSnapshot(travelcardQuery.data());

      // (travelcardQuery).data['balance'].toString();

      /*
        If the operator that charged the transaction is Dublin Bus or Go Ahead, 
        then we'll update the bus capping and multi mode capping by adding the current value
        that's stored in the account with the amount chargerd for the transaction
      */
      if (selectedOperator == "Dublin Bus" || selectedOperator == "Go-Ahead") {
        await usersCollection
            .doc(uid)
            .collection('travel_card')
            .doc(travelCardDoc)
            .update({
          'balance': travelCardBalance - amount,
          'bus_cap': travelCardBusCap + amount,
          'multi_mode_cap': travelCardMultiModeCap + amount,
        });
      }
      /*
        If the operator that charged the transaction is Iarnrod Eireann, 
        then we'll update the train capping and multi mode capping by adding the current value
        that's stored in the account with the amount chargerd for the transaction
      */
      else if (selectedOperator == "Iarnrod Eireann") {
        await usersCollection
            .doc(uid)
            .collection('travel_card')
            .doc(travelCardDoc)
            .update({
          'balance': travelCardBalance - amount,
          'multi_mode_cap': travelCardMultiModeCap + amount,
          'train_cap': travelCardTrainCap + amount,
        });
      }
      /*
        If the operator that charged the transaction is Luas, then we'll update the tram
        capping and multi mode capping by adding the current value that's stored in the 
        account with the amount chargerd for the transaction
      */
      else {
        //Tram
        await usersCollection
            .doc(uid)
            .collection('travel_card')
            .doc(travelCardDoc)
            .update({
          'balance': travelCardBalance - amount,
          'multi_mode_cap': travelCardMultiModeCap + amount,
          'tram_cap': travelCardTramCap + amount,
        });
      }
      // if (selectedOperator == "Dublin Bus" || selectedOperator == "Go-Ahead") {
      //   await usersCollection
      //       .doc(uid)
      //       .collection('travel_card')
      //       .doc(travelCardDoc)
      //       .update({
      //     'balance': travelCardModel.balance! - amount,
      //     'bus_cap': travelCardModel.busCap! + amount,
      //     'multi_mode_cap': travelCardModel.multiModeCap! + amount,
      //   });
      // } else if (selectedOperator == "Iarnrod Eireann") {
      //   await usersCollection
      //       .doc(uid)
      //       .collection('travel_card')
      //       .doc(travelCardDoc)
      //       .update({
      //     'balance': travelCardModel.balance! - amount,
      //     'multi_mode_cap': travelCardModel.multiModeCap! + amount,
      //     'train_cap': travelCardModel.trainCap! + amount,
      //   });
      // } else {
      //   //Tram
      //   await usersCollection
      //       .doc(uid)
      //       .collection('travel_card')
      //       .doc(travelCardDoc)
      //       .update({
      //     'balance': travelCardModel.balance! - amount,
      //     'multi_mode_cap': travelCardModel.multiModeCap! + amount,
      //     'tram_cap': travelCardModel.tramCap! + amount,
      //   });
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  /* Function to update the travel card balance that is connected to the user account in the firebase database */
  Future addTransactionToUserTicket(String uid, String docID, double amount,
      String selectedOperator, String selectedRoute, DateTime date) async {
    try {
      await usersCollection.doc(uid).collection('ticket').doc(docID).update({
        'activated': false,
        'amount': amount,
        'date': date,
        'operator': selectedOperator,
        'route': selectedRoute,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /* Function to get the relevant information from the ticket that is connected to the user account in the firebase database */
  Future getUserTicketInfo(String uid, String docID) async {
    try {
      bool ticketStatus;
      DocumentSnapshot value =
          await usersCollection.doc(uid).collection('ticket').doc(docID).get();

      ticketStatus = value['activated'];
      return ticketStatus;
    } catch (e) {
      print(e.toString());
    }
  }

  /* Function to get the relevant information from the ticket that is connected to the user account in the firebase database */
  Future getUserTravelCardInfo(String uid, String docID) async {
    try {
      return await usersCollection
          .doc(uid)
          .collection('travel_card')
          .doc(docID)
          .get();
    } catch (e) {
      print(e.toString());
    }
  }
}
