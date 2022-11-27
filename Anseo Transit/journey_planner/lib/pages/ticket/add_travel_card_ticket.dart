import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/pages/ticket/add_ticket.dart';
import 'package:journey_planner/pages/ticket/add_travel_card.dart';

class AddTravelCardOrTicket extends StatefulWidget {
  const AddTravelCardOrTicket({Key? key}) : super(key: key);

  @override
  State<AddTravelCardOrTicket> createState() => _AddTravelCardOrTicketState();
}

class _AddTravelCardOrTicketState extends State<AddTravelCardOrTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Add Travel Card or Ticket',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  child: Image.asset(
                                    'assets/icons/ticket.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Add Ticket',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTicket()),
                    ),
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  child: Image.asset(
                                    'assets/icons/travel_card.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Add Travel Card',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTravelCard()),
                    ),
                  ),
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.blue),
                  //   ),
                  //   onPressed: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => AddTravelCard()),
                  //   ),
                  //   child: const Text(
                  //     'Add Travel Card',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.blue),
                  //   ),
                  //   onPressed: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => AddTicket()),
                  //   ),
                  //   child: const Text(
                  //     'Add Ticket',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
