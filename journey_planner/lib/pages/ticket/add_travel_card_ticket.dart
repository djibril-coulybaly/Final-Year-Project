import 'package:flutter/material.dart';
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
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Add Travel Card or Ticket'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTravelCard()),
              ),
              child: const Text(
                'Add Travel Card',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTicket()),
              ),
              child: const Text(
                'Add Ticket',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
