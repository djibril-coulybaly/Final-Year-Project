/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: add_ticket.dart
  Description: This file will give the user the option to purchase a ticket. The user will be able to select either a child
               ticket or an adult ticket - each with their own respecitive fare prices. Once a ticket has been seleceted, 
               the user will be prompted to enter in their card details. This will be done using the Stripe Payment Gateway. 
               Once all the necessary information is entered, a payment intent is made to our Cloud Function. Once accepted and 
               the transaction is sucessfully carried out, a firebase call is made to create a new document under the 'ticket'
               collection in which the status of the ticket, the transaction amount, the date of the transaction, 
               the transport operator, the price of the ticket, the route taken in the transaction, the transaction ID and the ticket 
               type is stored. Once completed, the user will be informed of the sucessful transaction and subsequently given the option 
               to use the ticket (Which will be validated using Anseo Validator) or return to the homepage (ticket_overview.dart).

               I learned how to implement the payment intent by following the following YouTube tutorial: https://www.youtube.com/watch?v=vXNtA0J2WdU
               I also gained further knowlegde by consulting the official documentation from Stripe.
*/

// Imports utilised in this file
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:journey_planner/pages/ticket/use_travel_card_ticket.dart';
import 'package:journey_planner/services/firebase_database.dart';
import 'package:sweetsheet/sweetsheet.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({Key? key}) : super(key: key);

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  @override
  Widget build(BuildContext context) {
    // Instance of the Firebase Authentication SDK
    final FirebaseAuth _auth = FirebaseAuth.instance;

    // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
    final SweetSheet _sweetSheet = SweetSheet();

    // Instance of the class FDB located in firebase_database.dart, allowing us to make CRUD operations with the user data stored in Firebase
    final FDB _dbAuth = FDB(uid: _auth.currentUser!.uid);

    /* 
      Function that will allow the user to enter their payment information, verify the information and proceed with carrying out 
      the transaction. If successful, the user will be given the option to use their ticket or return to the ticket overview screen 
      This function takes 2 parameters, the email address of the user and the price of the ticket they have selected. 
    */
    Future<void> initPaymentSheet(context,
        {required String email, required int amount}) async {
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

        // Firebase query to create a new document under the 'tickets' collection within the user's account
        final document = FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('ticket')
            .doc();

        inspect(document);

        /* 
          Storing the ticket type and price depending on the value that was passed as a parameter when the user selected a ticket 
          If the amount is equal to 080 or €0.80, then the ticket selected was a Child Ticket and the appropiate values will be 
          stored. Othewise, the ticket selected was an Adult Ticket and the appropiate values will be stored.
        */
        String ticketType = (amount == 080) ? "Child" : "Adult";
        double ticketPrice = (amount == 080) ? 0.80 : 2.50;

        /* 
          Making a call to our firebase function in 'firebase_database.dart' where we will create a new document 
          under the 'tickets' collection within the user's account. Were taking the id of the document that we created 
          above and are using it to create a new document with the following information
        */
        await _dbAuth.initUserTicket(true, 0, DateTime.now(), "", ticketPrice,
            "", "", ticketType, document);

        /*
          Informing the user that the payment has been completed sucessfully, giving them the option to either use the 
          ticket now or return to the home page. If any error occurs through the transaction process, the relevant error
          message will be displayed to the user
        */
        _sweetSheet.show(
          isDismissible: false,
          context: context,
          title: const Text("Payment Succcessful"),
          description: const Text(
              "The payment has been completed sucessfully. Click on 'Use' to use the ticket or 'Return' to return to the homepage"),
          color: SweetSheetColor.SUCCESS,
          icon: Icons.task_alt_sharp,
          positive: SweetSheetAction(
            /* 
              If the user clicks on 'Use', they will be redirected to the use travel card or ticket screen 
              (use_travel_card_ticket.dart). The class takes the newly created document from firebase as a parameter
              along with the string value 'ticket' to generate a unique QR code.
            */
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UseTravelCardOrTicket(
                          _auth.currentUser!.uid, document.id, "ticket")));
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
          'Add Ticket',
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
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Adult Ticket Button
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          // Styling the Container
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),

                          // Image icon for the Adult Ticket
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: Image.asset(
                                    'assets/icons/adult.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Adult Ticket with Price
                        const SizedBox(height: 12),
                        Text(
                          'Adult Ticket - €2.50',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    /* 
                      If the user clicks on the button, the user will be presented with a payment sheet from Stripe, 
                      which will allow them to enter their payment information and carry out the transaction.
                    */
                    onTap: () async {
                      await initPaymentSheet(context,
                          email: _auth.currentUser!.email!, amount: 250);
                    },
                  ),

                  // Child Ticket Button
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          // Styling the Container
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),

                          // Icon Image for Child Ticket
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: Image.asset(
                                    'assets/icons/child.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Child Ticket with price
                        const SizedBox(height: 12),
                        Text(
                          'Child Ticket - €0.80',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    /* 
                      If the user clicks on the button, the user will be presented with a payment sheet from Stripe, 
                      which will allow them to enter their payment information and carry out the transaction 
                    */
                    onTap: () async {
                      await initPaymentSheet(context,
                          email: _auth.currentUser!.email!, amount: 080);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
