import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journey_planner/models/ticket.dart';
import 'package:journey_planner/pages/ticket/activity.dart';
import 'package:journey_planner/pages/ticket/add_travel_card_ticket.dart';
import 'package:journey_planner/pages/ticket/balance.dart';
import 'package:journey_planner/pages/ticket/capping.dart';
import 'package:journey_planner/pages/ticket/delete_travel_card.dart';
import 'package:journey_planner/pages/ticket/top_up_travel_card.dart';
import 'package:journey_planner/pages/ticket/use_ticket.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String _currentTicketID = "";
String _currentTicketType = "";

class TicketOverview extends StatefulWidget {
  const TicketOverview({Key? key}) : super(key: key);

  @override
  State<TicketOverview> createState() => _TicketOverviewState();
}

class _TicketOverviewState extends State<TicketOverview> {
  int _currentIndex = 0;

  List<Ticket> _ticketTravelCardList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsersTicketTravelCardList();
  }

  @override
  Widget build(BuildContext context) {
    inspect(_ticketTravelCardList);
    // _currentTicketID = _ticketTravelCardList[0].ticketID!;
    inspect(_currentTicketID);

    print(_ticketTravelCardList.runtimeType);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Ticket Overview'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // ListView.builder(
                //     itemCount: _ticketTravelCardList.length,
                //     itemBuilder: (context, index) {
                //       return DisplayTicketTravelCard(
                //           _ticketTravelCardList[index] as Ticket);
                //     }),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    // autoPlayInterval: Duration(seconds: 3),
                    // autoPlayAnimationDuration: Duration(milliseconds: 800),
                    // autoPlayCurve: Curves.fastOutSlowIn,
                    // pauseAutoPlayOnTouch: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                        _currentTicketID =
                            _ticketTravelCardList[index].ticketID!;
                        _currentTicketType = _ticketTravelCardList[index].type!;
                      });
                    },
                  ),
                  items: _ticketTravelCardList.map((card) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: getColorType(card.type),
                          child: Column(
                            children: [
                              Row(
                                children: [Text("ID = ${card.ticketID}")],
                              ),
                              Row(
                                children: [Text("Status = ${card.activated}")],
                              ),
                              Row(
                                children: [Text("Type = ${card.type}")],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(_ticketTravelCardList, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20.0),
                UseCardTicketWidget(),
                const SizedBox(height: 20.0),
                AddCardTicketWidget(),
                const SizedBox(height: 20.0),
                (_ticketTravelCardList.runtimeType != List<Ticket>)
                    ? DeleteTravelCardWidget()
                    : Container(),
                const SizedBox(height: 20.0),
                (_ticketTravelCardList.runtimeType != List<Ticket>)
                    ? TopUpTravelCardWidget()
                    : Container(),
                const SizedBox(height: 20.0),
                ActivityWidget(),
                const SizedBox(height: 20.0),
                (_ticketTravelCardList.runtimeType != List<Ticket>)
                    ? BalanceWidget()
                    : Container(),
                const SizedBox(height: 20.0),
                (_ticketTravelCardList.runtimeType != List<Ticket>)
                    ? CappingWidget()
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getUsersTicketTravelCardList() async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('ticket')
        .get();

    // inspect(data);

    setState(() {
      _ticketTravelCardList =
          List.from(data.docs.map((doc) => Ticket.fromSnapshot(doc)));
      _currentTicketID = _ticketTravelCardList[0].ticketID!;
      _currentTicketType = _ticketTravelCardList[0].type!;
    });

    // inspect(_ticketTravelCardList);
  }
}

getColorType(String? type) {
  if (type == "Student") {
    return Colors.green[300];
  } else if (type == "Child") {
    return Colors.deepPurple[200];
  } else {
    return Colors.blue[100];
  }
}

class CappingWidget extends StatelessWidget {
  const CappingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.orange[400]),
      // color: Colors.pink[400],
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Capping()),
      ),
      child: const Text(
        'Capping',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.orange[400]),
      // color: Colors.pink[400],
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Balance()),
      ),
      child: const Text(
        'Balance',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.orange[400]),
      // color: Colors.pink[400],
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Activity()),
      ),
      child: const Text(
        'Activity',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class TopUpTravelCardWidget extends StatelessWidget {
  const TopUpTravelCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.orange[400]),
      // color: Colors.pink[400],
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TopUpTravelCard()),
      ),
      child: const Text(
        'Top Up Travel Card',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class DeleteTravelCardWidget extends StatelessWidget {
  const DeleteTravelCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.red[800]),
      // color: Colors.pink[400],
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DeleteTravelCard()),
      ),
      child: const Text(
        'Delete Travel Card',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class AddCardTicketWidget extends StatelessWidget {
  const AddCardTicketWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.orange[400]),
      // color: Colors.pink[400],
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTravelCardOrTicket()),
      ),
      child: const Text(
        'Add Card/Ticket',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class UseCardTicketWidget extends StatelessWidget {
  const UseCardTicketWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.orange[400]),
      // color: Colors.pink[400],
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UseTicket(_auth.currentUser!.uid, _currentTicketID)),
      ),
      child: const Text(
        'Use Card/Ticket',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
