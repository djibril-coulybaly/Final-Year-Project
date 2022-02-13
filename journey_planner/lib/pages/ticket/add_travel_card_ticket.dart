import 'package:flutter/material.dart';

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
      body: Stack(),
    );
  }
}
