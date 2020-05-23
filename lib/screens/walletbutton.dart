import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metropay/models/user.dart';
import 'package:metropay/services/database.dart';
import 'package:metropay/utilities/loading.dart';
import './addMoneybutton.dart';
import 'package:provider/provider.dart';

class WalletButton extends StatefulWidget {
  @override
  _WalletButtonState createState() => _WalletButtonState();
}

class _WalletButtonState extends State<WalletButton> {

   var balanceAmount = 0.0;

  Widget _metroPayAmount() {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          return Card(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 15.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'MetroPay Balance',
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 0.8,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(height: 4, color: Color(0xFF61A4F1),
                    margin: const EdgeInsets.only(left: 0.0, right: 190.0),),
                  SizedBox(height: 10.0),
                  Text(
                    '₹ '+ userData.balance.toString(),
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ],
              ),
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }

  Widget _addMoneyBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMoneyButton()),
          );
         setState(() {
         });
        balanceAmount=balanceAmount+100;
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
//        color: Colors.white,
        child: Text(
          'Add money to wallet',
          style: TextStyle(
//            color: Color(0xFF478DE0),
            letterSpacing: 1.5,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
//          height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'MetroPay',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _metroPayAmount(),
//                      SizedBox(height: 10.0),
                      _addMoneyBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
