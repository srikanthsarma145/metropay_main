import 'package:flutter/material.dart';
import 'package:metropay/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetroPay',
      theme: ThemeData(
//          canvasColor: Color(0xffffffff),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xfffefefe),
          ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
          canvasColor: Color(0xffcccccc),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff404040),
          ),
//          cardTheme: CardTheme(
//            color: Color(0xff404040),
//          )
      ),
//      debugShowCheckedModeBanner: false, //remove comment to remove debug tag
      home: LoginScreen(),
    );
  }
}

