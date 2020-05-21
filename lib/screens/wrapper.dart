import 'package:metropay_test/models/user.dart';
import 'package:metropay_test/screens/login_screen.dart';
import 'package:metropay_test/screens/homepage_screen.dart';
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