/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: top_up_travel_card.dart
  Description: This file will give the user the option to top up their travel card. The user will be able to select the amount
               that they want to top up by - in increments of €5 up to €100. Once an amount has been seleceted, 
               the user will be prompted to enter in their card details. This will be done using the Stripe Payment Gateway. 
               Once all the necessary information is entered, a payment intent is made to our Cloud Function. Once accepted and 
               the transaction is sucessfully carried out, a firebase call is made to update the relevant fields. Once completed, 
               the user will be informed of the sucessful transaction and subsequently given the option to use the travel card 
               (Which will be validated using Anseo Validator) or return to the homepage (ticket_overview.dart).

               I learned how to implement the payment intent by following the following YouTube tutorial: https://www.youtube.com/watch?v=vXNtA0J2WdU
               The Number Picker was obtained from the flutter package 'numberpicker'. I also gained further knowlegde by consulting 
               the official documentation from Stripe.
*/

// Imports utilised in this file
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as a;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:journey_planner/pages/ticket/use_travel_card_ticket.dart';
import 'package:journey_planner/services/firebase_database.dart';
import 'package:journey_planner/widgets/colour_type.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sweetsheet/sweetsheet.dart';

class TopUpTravelCard extends StatefulWidget {
  final dynamic card;

  const TopUpTravelCard(this.card, {Key? key}) : super(key: key);

  @override
  State<TopUpTravelCard> createState() => _TopUpTravelCardState();
}

class _TopUpTravelCardState extends State<TopUpTravelCard> {
  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final SweetSheet _sweetSheet = SweetSheet();

    final FDB _dbAuth = FDB(uid: _auth.currentUser!.uid);

    inspect(widget.card);

    /* 
      Function that will allow the user to enter their payment information, verify the information and proceed with carrying out 
      the transaction. If successful, the user will be given the option to use their ticket or return to the ticket overview screen 
      This function takes 3 parameters, the email address of the user, the new balance (Old balance + top up amount) on the travel 
      card and the amount selected to top up the travel card. 
    */
    Future<void> initPaymentSheet(context,
        {required String email,
        required int amount,
        required double newBalance}) async {
      try {
        /* 
          Creating a payment intent on the server using Cloud Functions. The reason why we're doing the payment intent on a server as opposed to in-app
          is to provide security.
        */
        final response = await http.post(
            Uri.parse(
                'https://us-central1-journey-planner-79eb0.cloudfunctions.net/stripePaymentIntentRequest'),
            body: {
              'email': email,
              'amount': amount.toString(),
            });

        final jsonResponse = jsonDecode(response.body);
        log(jsonResponse.toString());

        // Initializing the payment sheet with the following configurations:
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: jsonResponse['paymentIntent'],
            merchantDisplayName: 'Anseo Transit',
            customerId: jsonResponse['customer'],
            customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
            style: ThemeMode.light,
            testEnv: true,
            merchantCountryCode: 'IE',
            googlePay: true,
          ),
        );

        // Displaying the payment sheet to the user
        await Stripe.instance.presentPaymentSheet();

        /* 
          Making a call to our firebase function in 'firebase_database.dart' where we will update the balance of the  
          travel card. We're passing the id of the travel card alongside the new balance 
        */
        await _dbAuth.topUpUserTravelCard(newBalance, widget.card.travelCardID);

        /*
          Informing the user that the payment has been completed sucessfully, giving them the option to either use the 
          ticket now or return to the home page. If any error occurs through the transaction process, the relevant error
          message will be displayed to the user
        */
        _sweetSheet.show(
          isDismissible: false,
          context: context,
          title: const Text("Top Up Succcessful"),
          description: const Text(
              "Click on 'Use' to use the travel card or 'Return' to return to the homepage"),
          color: SweetSheetColor.SUCCESS,
          icon: Icons.task_alt_sharp,
          positive: SweetSheetAction(
            onPressed: () {
              /* 
              If the user clicks on 'Use', they will be redirected to the use travel card or ticket screen 
              (use_travel_card_ticket.dart). The class takes the user ID and travel card ID as a parameter
              along with the string value 'travel_card' to generate a unique QR code.
            */
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UseTravelCardOrTicket(
                          _auth.currentUser!.uid,
                          widget.card.travelCardID,
                          "travel_card")));
            },
            title: 'USE',
            icon: Icons.qr_code,
          ),
          negative: SweetSheetAction(
            // If the user clicks on 'Return', they will be redirected to the ticket overview screen (ticket_overview.dart)
            onPressed: () {
              Navigator.of(context).pop();
            },
            title: 'RETURN',
            icon: Icons.exit_to_app,
          ),
          // ),
        );
      } catch (e) {
        if (e is StripeException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error from Stripe: ${e.error.localizedMessage}'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Top Up Travel Card',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              // Displaying the Travel Card that the user wants to view the activity
              a.Card(
                // color: getColorType(card.type),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: getColorType(widget.card.type),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ticket/Travel Card + type and the Anseo logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Ticket/Travel Card + type
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${widget.card.type} ${widget.card.runtimeType}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Anseo Logo
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: SizedBox.square(
                                  dimension: 50,
                                  child: Image.asset(
                                    "assets/logo/logo1.png",
                                    width: 75,
                                    height: 68,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Balance on Travel Card/Ticket
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              "€${widget.card.balance}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),

                      // ID of ticket/travel card
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.card.travelCardID}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // Selecting amount to top up travel card by
              Text('Select Amount',
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 60),
              NumberPicker(
                value: _currentHorizontalIntValue,
                minValue: 5,
                maxValue: 100,
                step: 5,
                itemHeight: 100,
                axis: Axis.horizontal,
                onChanged: (value) =>
                    setState(() => _currentHorizontalIntValue = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black26),
                ),
              ),
              const SizedBox(height: 60),

              // Displaying new balance on card if the travel card is topped up by €x
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() {
                      final newValue = _currentHorizontalIntValue - 5;
                      _currentHorizontalIntValue = newValue.clamp(5, 100);
                    }),
                  ),
                  Text(
                      'New balance on card: €${widget.card.balance + _currentHorizontalIntValue}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() {
                      final newValue = _currentHorizontalIntValue + 5;
                      _currentHorizontalIntValue = newValue.clamp(5, 100);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  /* 
                    If the user clicks on the button, the user will be presented with a payment sheet from Stripe, 
                    which will allow them to enter their payment information and carry out the transaction 
                  */
                  onPressed: () async {
                    await initPaymentSheet(
                      context,
                      email: _auth.currentUser!.email!,
                      amount: changeAmountFormat(_currentHorizontalIntValue),
                      newBalance:
                          widget.card.balance + _currentHorizontalIntValue,
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4158D0),
                          Color(0xFFC850C0),
                        ],
                      ),
                    ),
                    child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Top Up Travel Card: €$_currentHorizontalIntValue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Function to format the amount number for Stripe
changeAmountFormat(int amount) {
  String newAmount;
  newAmount = amount.toString() + '00';
  return int.parse(newAmount);
}
