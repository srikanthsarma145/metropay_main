import 'package:metropay/models/user.dart';
import 'package:metropay/screens/login_screen.dart';
import 'package:metropay/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return LoginScreen();
    } else {
      return HomeScreen();
    }

  }
}