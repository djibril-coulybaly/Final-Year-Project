import 'package:flutter/material.dart';
import 'package:journey_planner/models/user.dart';
import 'package:journey_planner/pages/authentication/authenticate.dart';
import 'package:journey_planner/pages/home/home.dart';
import 'package:provider/provider.dart';

class WrapperForFirebase extends StatelessWidget {
  const WrapperForFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print(user);

    /* 
      If the user is not logged in, return to the authenticate widget,
      otherwise return to the home widget 
    */
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
