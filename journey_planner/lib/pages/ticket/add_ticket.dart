import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:journey_planner/pages/ticket/use_ticket.dart';
import 'package:journey_planner/services/firebase_database.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:journey_planner/pages/ticket/use_travel_card_ticket.dart';

class AddTicket extends StatefulWidget {
  AddTicket({Key? key}) : super(key: key);

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  // _stepState(int step) {
  //   if (_currentStep > step) {
  //     return StepState.complete;
  //   } else {
  //     return StepState.indexed;
  //   }
  // }

  // _steps() => [
  //       Step(
  //         title: Text('Select Ticket'),
  //         content: _SelectTicket(),
  //         state: _stepState(0),
  //         isActive: _currentStep == 0,
  //       ),
  //       Step(
  //         title: Text('Payment'),
  //         content: _Payment(),
  //         state: _stepState(1),
  //         isActive: _currentStep == 1,
  //       ),
  //       Step(
  //         title: Text('View Ticket'),
  //         content: UseTravelCardOrTicket(),
  //         state: _stepState(2),
  //         isActive: _currentStep == 2,
  //       )
  //     ];
  // int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final SweetSheet _sweetSheet = SweetSheet();

    final FDB _dbAuth = FDB(uid: _auth.currentUser!.uid);

    Future<void> initPaymentSheet(context,
        {required String email, required int amount}) async {
      try {
        // 1. create payment intent on the server
        final response = await http.post(
            Uri.parse(
                'https://us-central1-journey-planner-79eb0.cloudfunctions.net/stripePaymentIntentRequest'),
            body: {
              'email': email,
              'amount': amount.toString(),
            });

        final jsonResponse = jsonDecode(response.body);
        log(jsonResponse.toString());

        await Stripe.instance.initGooglePay(const GooglePayInitParams(
            testEnv: true,
            merchantName: "Example Merchant Name",
            countryCode: 'IE'));

        await Stripe.instance.presentGooglePay(
          PresentGooglePayParams(clientSecret: jsonResponse['paymentIntent']),
        );
        //2. initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: jsonResponse['paymentIntent'],
            merchantDisplayName: 'Anseo Journey Planner',
            customerId: jsonResponse['customer'],
            customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
            style: ThemeMode.light,
            testEnv: true,
            merchantCountryCode: 'IE',
            googlePay: true,
          ),
        );

        await Stripe.instance.presentPaymentSheet();

        final document = FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('ticket')
            .doc();

        inspect(document);

        String ticketType = (amount == 080) ? "Child" : "Adult";
        double ticketPrice = (amount == 080) ? 0.80 : 2.50;

        await _dbAuth.initUserTicket(true, 0, DateTime.now(), "", ticketPrice,
            "", "", ticketType, document);

        // ScaffoldMessenger.of(context).showSnackBar(
        // const SnackBar(content: Text('Payment completed!')),
        _sweetSheet.show(
          isDismissible: false,
          context: context,
          title: Text("Payment Succcessful"),
          description: Text(
              "The payment has been completed sucessfully. Click on 'Use' to use the ticket or 'Return' to return to the homepage"),
          color: SweetSheetColor.SUCCESS,
          icon: Icons.task_alt_sharp,
          positive: SweetSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UseTicket(_auth.currentUser!.uid, document.id)));
            },
            title: 'USE',
            icon: Icons.qr_code,
          ),
          negative: SweetSheetAction(
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
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Add Ticket'),
      ),
      // body: Stepper(
      //   type: StepperType.horizontal,
      //   onStepTapped: (step) => setState(() => _currentStep = step),
      //   onStepContinue: () {
      //     setState(() {
      //       if (_currentStep < _steps().length - 1) {
      //         _currentStep += 1;
      //       } else {
      //         _currentStep = 0;
      //       }
      //     });
      //   },
      //   onStepCancel: () {
      //     setState(() {
      //       if (_currentStep > 0) {
      //         _currentStep -= 1;
      //       } else {
      //         _currentStep = 0;
      //       }
      //     });
      //   },
      //   currentStep: _currentStep,
      //   steps: _steps(),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                await initPaymentSheet(context,
                    email: _auth.currentUser!.email!, amount: 250);
              },
              child: const Text(
                'Adult Ticket - €2.50',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                await initPaymentSheet(context,
                    email: _auth.currentUser!.email!, amount: 080);
              },
              child: const Text(
                'Child Ticket - €0.80',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _SelectTicket extends StatefulWidget {
//   const _SelectTicket({Key? key}) : super(key: key);

//   @override
//   State<_SelectTicket> createState() => _SelectTicketState();
// }

// class _SelectTicketState extends State<_SelectTicket> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> initPaymentSheet(context,
//       {required String email, required int amount}) async {
//     try {
//       // 1. create payment intent on the server
//       final response = await http.post(
//           Uri.parse(
//               'https://us-central1-journey-planner-79eb0.cloudfunctions.net/stripePaymentIntentRequest'),
//           body: {
//             'email': email,
//             'amount': amount.toString(),
//           });

//       final jsonResponse = jsonDecode(response.body);
//       log(jsonResponse.toString());

//       //2. initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: jsonResponse['paymentIntent'],
//           merchantDisplayName: 'Flutter Stripe Store Demo',
//           customerId: jsonResponse['customer'],
//           customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
//           style: ThemeMode.light,
//           testEnv: true,
//           merchantCountryCode: 'IE',
//           googlePay: true,
//         ),
//       );

//       await Stripe.instance.presentPaymentSheet();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Payment completed!')),
//       );
//     } catch (e) {
//       if (e is StripeException) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error from Stripe: ${e.error.localizedMessage}'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           style: ButtonStyle(
//             foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//           ),
//           onPressed: () async {
//             await initPaymentSheet(context,
//                 email: _auth.currentUser!.email!, amount: 250);
//           },
//           child: const Text(
//             'Adult Ticket - €2.50',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         ElevatedButton(
//           style: ButtonStyle(
//             foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//           ),
//           onPressed: () async {
//             await initPaymentSheet(context,
//                 email: _auth.currentUser!.email!, amount: 080);
//           },
//           child: const Text(
//             'Child Ticket - €0.80',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _Payment extends StatelessWidget {
//   const _Payment({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: const InputDecoration(
//             labelText: 'Street',
//           ),
//         ),
//         TextFormField(
//           decoration: const InputDecoration(
//             labelText: 'City',
//           ),
//         ),
//         TextFormField(
//           decoration: const InputDecoration(
//             labelText: 'Postcode',
//           ),
//         ),
//       ],
//     );
//   }
// }
