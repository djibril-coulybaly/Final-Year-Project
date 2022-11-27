/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: select_option_for_driver.dart
  Description: This file will allow the driver to select the options needed to carry out a transaction. 
               
               A driver must select one from each of the follwing:
               - Route = list will be populated depending on what operator the driver works for  
               - Fare Type = Child, Adult or Student
               - Payment Method = QR Code or NFC

               Once the options have been seleceted, the commuter will then proceed to scan their ticket or 
               travel card using the QR Code Scanner or scan their NFC travel card. In either case the data embedded within the 
               two payment methods will be decrypted, validated, and used to charging the transaction to the commuters account

               I learned how to implement the QR Code Scanner by following the following YouTube tutorial: https://www.youtube.com/watch?v=Z32WsUiOegs
               The code for implementing the NFC scanner was found in the example folder of the package 'nfc_manager', which is being used in this project
*/

// Imports utilised in this file
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validator/firebase_wrapper.dart';
import 'package:validator/models/radio_model.dart';
import 'package:validator/models/routes.dart';
import 'package:validator/pages/display_transaction.dart';
import 'package:validator/pages/nfc_scan.dart';
import 'package:validator/services/aes_encryption.dart';
import 'package:validator/services/firebase_auth.dart';
import 'package:validator/services/firebase_database.dart';
import 'package:validator/widgets/radio_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetsheet/sweetsheet.dart';

class SelectOptionForDriver extends StatefulWidget {
  /* 
    This class takes in 1 parameters: 
    - The ID of the driver signed in to the application. 
    
    This will later be used to get the name of the operator that the
    driver works for 
  */
  final dynamic uid;
  const SelectOptionForDriver(this.uid, {Key? key}) : super(key: key);

  @override
  State<SelectOptionForDriver> createState() => _SelectOptionForDriverState();
}

class _SelectOptionForDriverState extends State<SelectOptionForDriver> {
  // Initialising variables used to store the selection from the driver
  int currentStep = 0;
  String selectedOperator = "";
  String selectedRoute = "";
  String selectedFare = "";
  String selectedPM = "";

  // Instance of the AES Encryption Class - allows us to decrypt the data that we want to obtain from the QR Code
  AESEncryption encryption = AESEncryption();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  // Initialising list of routes, fare types and payment method that will be displayed in the Stepper widget
  List<Routes> operatorRoutes = [];

  List<RadioModel> fareType = [
    RadioModel(false, "Child", Icons.face),
    RadioModel(false, "Student", Icons.school),
    RadioModel(false, "Adult", Icons.person),
  ];

  List<RadioModel> paymentMethod = [
    RadioModel(false, "QR Code", Icons.qr_code_scanner),
    RadioModel(false, "NFC", Icons.payment),
  ];

  /* 
    Function call to get a list of route from one of the 4 operators, depending on what operator the driver works for. 
  */
  Future<void> readJson() async {
    // Firebase query to get all the information that is stored on the driver account
    var travelCardData = await FirebaseFirestore.instance
        .collection('drivers')
        .doc(widget.uid)
        .get();

    // Storing the name of the operator that the driver works for
    var operatorName = travelCardData.data()!["operator"];

    // Getting JSON data of routes
    final String operatorResponse = operatorName == "Dublin Bus"
        ? await rootBundle.loadString('assets/dublinBusRoutes.json')
        : operatorName == "Go Ahead"
            ? await rootBundle.loadString('assets/goAheadRoutes.json')
            : operatorName == "Iarnrod Eireann"
                ? await rootBundle
                    .loadString('assets/iarnrodEireannRoutes.json')
                : await rootBundle.loadString('assets/luasRoutes.json');

    // Converting and mapping the JSON data to a list with a SearchRoute Class
    final operatorData = await json.decode(operatorResponse) as List;

    // Setting the list of routes and operator name so that we can access it when the page loads
    setState(() {
      operatorRoutes = operatorData.map((e) => Routes.fromJson(e)).toList();

      selectedOperator = operatorName;
    });
  }

  /* 
    List that will contain all the steps that will be presented in the Stepper widget
  */
  List<Step> getSteps() => [
        // 1. Select Route
        Step(
            title: Text(
              "Select Route",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.manrope().fontFamily,
                color: Colors.black,
              ),
            ),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,

            // state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.height / 800,
                  ),
                  itemCount: operatorRoutes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: operatorRoutes[index].isSelected
                          ? RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.indigoAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0))
                          : RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color(0xFFEEEEEE), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0)),
                      color: Colors.white,
                      elevation: 0,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            for (var element in operatorRoutes) {
                              element.isSelected = false;
                            }
                            operatorRoutes[index].isSelected = true;
                            selectedRoute = operatorRoutes[index].route;
                            print("Route: ${selectedRoute}");
                          });
                        },
                        child: GridTile(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RadioItem(operatorRoutes[index]),
                        )),
                      ),
                    );
                  },
                ),
              ),
            )),

        // 2. Select Fare
        Step(
            title: Text(
              "Select Fare",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.manrope().fontFamily,
                color: Colors.black,
              ),
            ),
            isActive: currentStep >= 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            content: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.5),
              ),
              itemCount: fareType.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: fareType[index].isSelected
                      ? RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.indigoAccent, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0))
                      : RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xFFEEEEEE), width: 2.0),
                          borderRadius: BorderRadius.circular(4.0)),
                  color: Colors.white,
                  elevation: 0,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        for (var element in fareType) {
                          element.isSelected = false;
                        }
                        fareType[index].isSelected = true;
                        selectedFare = fareType[index].name;
                        print("Fare: ${selectedFare}");
                      });
                    },
                    child: GridTile(child: RadioItem(fareType[index])),
                  ),
                );
              },
            )),

        // 3. Select Payment Method
        Step(
            title: Text(
              "Select Payment Method",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.manrope().fontFamily,
                color: Colors.black,
              ),
            ),
            isActive: currentStep >= 2,
            content: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.5),
              ),
              itemCount: paymentMethod.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: paymentMethod[index].isSelected
                      ? RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.indigoAccent, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0))
                      : RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xFFEEEEEE), width: 2.0),
                          borderRadius: BorderRadius.circular(4.0)),
                  color: Colors.white,
                  elevation: 0,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        for (var element in paymentMethod) {
                          element.isSelected = false;
                        }
                        paymentMethod[index].isSelected = true;
                        selectedPM = paymentMethod[index].name;
                        print("Payment Method: ${selectedPM}");
                      });
                    },
                    child: GridTile(child: RadioItem(paymentMethod[index])),
                  ),
                );
              },
            )),
      ];

  @override
  void initState() {
    super.initState();

    /* 
      Function call to get a list of route from one of the 4 operators, depending on what operator the driver works for.
      This is being called in the initState() functions so that the data can be loaded before the screen is shown
    */
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    // Instance of the class FAS located in firebase_auth.dart, allowing us to authenticate the user with Firebase
    final FAS _auth = FAS();

    // inspect(operatorRoutes);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Anseo Validator',
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.manrope().fontFamily,
              color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const WrapperForFirebase(),
                ),
              );
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Stepper(
        steps: getSteps(),
        type: StepperType.vertical,
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          /*
            If the driver is on the last step, they'll either be redirected to scan the QR code or scan the NFC travel card,
            depending on the method of payment selected
          */
          if (isLastStep) {
            if (selectedPM == "QR Code") {
              scanQRCode();
            } else {
              print("Operator: ${selectedOperator}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NFCScan(
                      selectedFare,
                      selectedOperator,
                      selectedRoute,
                    ),
                  ));
            }
            print("Completed");
          } else {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepTapped: (value) => setState(() {
          currentStep = value;
        }),
        onStepCancel: () {
          currentStep == 0
              ? null
              : setState(() {
                  currentStep -= 1;
                });
        },
        controlsBuilder: (context, controls) {
          final isLastStep = currentStep == getSteps().length - 1;

          return Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                if (currentStep != 0)
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "BACK",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: controls.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                if (currentStep != 0) const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                      isLastStep ? "CONFIRM" : "NEXT",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: controls.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /*
    Function to scan the QR code, decrypt the contents of the QR code, validate the method 
    of payment and proceed with charging the transaction to the user account
 */
  Future<void> scanQRCode() async {
    try {
      // Initialising the QR code scanner
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      // Decrypting the message embedded in the QR code
      final decryptedQRCode =
          encryption.decryptDocID(encryption.getCode(qrCode)).toString();

      /* 
        Printing the contents of the QR code. It should be in the following format
        (User ID)/(travel_card or ticket)/(Travel Card/Ticket ID)
      */
      print('BARCODE' + decryptedQRCode);

      // Breaking down the decrypted message and placing them in their appropiate variables
      final qrDetails = decryptedQRCode.split('/');
      final uid = qrDetails[0];
      final ticketOrTravelCard = qrDetails[1];
      final docID = qrDetails[2];
      final amount = (selectedFare == "Child") ? 0.80 : 2.50;
      final date = DateTime.now();
      final FDB _dbAuth = FDB();
      // final FDB _dbAuth = FDB(
      //     // uid: uid, ticketOrTravelCard: ticketOrTravelCard, docID: docID
      //     );

      /*
        If the QR code scanned was a travel card, then we'll proceed with verifying the information on the travel card. 
        Otherwise, the QR code scanned was a ticket and subsequently well proceed with verifying the information on the ticket
      */
      if (ticketOrTravelCard == "travel_card") {
        // Get the most recent data from the travel card via firebase query
        dynamic travelCardInfo =
            await _dbAuth.getUserTravelCardInfo(uid, docID);
        var travelCardBalance = travelCardInfo.data()!["balance"].toDouble();
        var travelCardBusCap = travelCardInfo.data()!["bus_cap"].toDouble();
        var travelCardMultiModeCap =
            travelCardInfo.data()!["multi_mode_cap"].toDouble();
        var travelCardTrainCap = travelCardInfo.data()!["train_cap"].toDouble();
        var travelCardTramCap = travelCardInfo.data()!["tram_cap"].toDouble();

        /*
          If the balance on the travel card is not €0.00, then we'll proceed to see if the commuter has reached 
          the cap limit on the specific mode of transportation or has reached the multi mode cap limit. 

          Note: The cap limit have been set as follows
                - Bus Cap = €10
                - Train Cap = €10
                - Tram Cap = €10
                - Multi Mode Cap = €20
          
          If they have reached the cap limit, then well proceed to create a new transaction with €0.00 being the amount
          charged, and update the capping information. Otherwise they will be charged with the amount specified at the 
          start of the transaction.

          If the balmpoance on the travel card is €0.00, then an error message will be displayed informing the driver that
          the commuter doesn't have any money on the travel card.
        */
        if (travelCardBalance != 0.0) {
          if (selectedOperator == "Dublin Bus" ||
              selectedOperator == "Go-Ahead") {
            if (travelCardBusCap >= 10 || travelCardMultiModeCap >= 20) {
              await _dbAuth.addTransactionToUserTravelCard(
                  uid, docID, 0.0, selectedOperator, selectedRoute, date);

              await _dbAuth.updateCappingUserTravelCard(
                  uid, docID, 0.0, selectedOperator, selectedRoute);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayTransaction(
                    uid,
                    "Travel Card",
                    docID,
                    0.0,
                    date,
                    selectedFare,
                    selectedOperator,
                    selectedRoute,
                  ),
                ),
              );
            } else {
              await _dbAuth.addTransactionToUserTravelCard(
                  uid, docID, amount, selectedOperator, selectedRoute, date);

              await _dbAuth.updateCappingUserTravelCard(
                  uid, docID, amount, selectedOperator, selectedRoute);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayTransaction(
                    uid,
                    "Travel Card",
                    docID,
                    amount,
                    date,
                    selectedFare,
                    selectedOperator,
                    selectedRoute,
                  ),
                ),
              );
            }
          } else if (selectedOperator == "Iarnrod Eireann") {
            if (travelCardTrainCap >= 10 || travelCardMultiModeCap >= 20) {
              await _dbAuth.addTransactionToUserTravelCard(
                  uid, docID, 0.0, selectedOperator, selectedRoute, date);

              await _dbAuth.updateCappingUserTravelCard(
                  uid, docID, 0.0, selectedOperator, selectedRoute);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayTransaction(
                    uid,
                    "Travel Card",
                    docID,
                    0.0,
                    date,
                    selectedFare,
                    selectedOperator,
                    selectedRoute,
                  ),
                ),
              );
            } else {
              await _dbAuth.addTransactionToUserTravelCard(
                  uid, docID, amount, selectedOperator, selectedRoute, date);

              await _dbAuth.updateCappingUserTravelCard(
                  uid, docID, amount, selectedOperator, selectedRoute);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayTransaction(
                    uid,
                    "Travel Card",
                    docID,
                    amount,
                    date,
                    selectedFare,
                    selectedOperator,
                    selectedRoute,
                  ),
                ),
              );
            }
          } else if (selectedOperator == "Luas") {
            if (travelCardTramCap >= 10 || travelCardMultiModeCap >= 20) {
              await _dbAuth.addTransactionToUserTravelCard(
                  uid, docID, 0.0, selectedOperator, selectedRoute, date);

              await _dbAuth.updateCappingUserTravelCard(
                  uid, docID, 0.0, selectedOperator, selectedRoute);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayTransaction(
                    uid,
                    "Travel Card",
                    docID,
                    0.0,
                    date,
                    selectedFare,
                    selectedOperator,
                    selectedRoute,
                  ),
                ),
              );
            } else {
              await _dbAuth.addTransactionToUserTravelCard(
                  uid, docID, amount, selectedOperator, selectedRoute, date);

              await _dbAuth.updateCappingUserTravelCard(
                  uid, docID, amount, selectedOperator, selectedRoute);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayTransaction(
                    uid,
                    "Travel Card",
                    docID,
                    amount,
                    date,
                    selectedFare,
                    selectedOperator,
                    selectedRoute,
                  ),
                ),
              );
            }
          }
          // await _dbAuth.addTransactionToUserTravelCard(
          //     uid, docID, amount, selectedOperator, selectedRoute, date);

          // await _dbAuth.updateCappingUserTravelCard(
          //     uid, docID, amount, selectedOperator, selectedRoute);

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => DisplayTransaction(
          //           uid,
          //           "Travel Card",
          //           docID,
          //           amount,
          //           date,
          //           selectedFare,
          //           selectedOperator,
          //           selectedRoute),
          //     ));
        } else {
          _sweetSheet.show(
            isDismissible: false,
            context: context,
            title: const Text("No Money on Travel Card"),
            description: const Text(
                "There is no money left on the travel card! Please use another ticket or travel card."),
            color: SweetSheetColor.DANGER,
            icon: Icons.warning,
            positive: SweetSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              title: 'DELETE',
              icon: Icons.delete_forever,
            ),
          );
        }
      } else {
        // Get the most recent data from the ticket via firebase query
        dynamic ticketStatus = await _dbAuth.getUserTicketInfo(uid, docID);

        /*
          If the ticket is valid, then well proceed to carry out the transaction. Otherwise an error message will be 
          displayed informing the driver that the commuter ticket has already been used.
        */
        if (ticketStatus) {
          await _dbAuth.addTransactionToUserTicket(
              uid, docID, amount, selectedOperator, selectedRoute, date);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayTransaction(
                    uid,
                    "Ticket",
                    docID,
                    amount,
                    date,
                    selectedFare,
                    selectedOperator,
                    selectedRoute),
              ));
        } else {
          _sweetSheet.show(
            isDismissible: false,
            context: context,
            title: const Text("Ticket Expired"),
            description: const Text(
                "This ticket has already been used! Please use another ticket or travel card."),
            color: SweetSheetColor.DANGER,
            icon: Icons.warning,
            positive: SweetSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              title: 'RETRY',
              icon: Icons.autorenew,
            ),
          );
        }
      }

      // final transactionDoc = (ticketOrTravelCard == "travel_card")
      //     ? FirebaseFirestore.instance
      //         .collection('users')
      //         .doc(uid)
      //         .collection(ticketOrTravelCard)
      //         .doc(docID)
      //         .collection("transactions")
      //         .doc()
      //     : FirebaseFirestore.instance
      //         .collection('users')
      //         .doc(uid)
      //         .collection(ticketOrTravelCard)
      //         .doc(docID)
      //         .update("data");
      // setState(() {
      //   this.qrCode = decryptedQRCode;
      // });

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DisplayTransaction(uid, "Ticket", docID,
      //           amount, date, selectedFare, selectedOperator, selectedRoute),
      //     ));
    } catch (e) {
      print(e.toString());
    }
  }
}
