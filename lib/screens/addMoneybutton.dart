import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metropay/models/user.dart';
import 'package:metropay/services/database.dart';
import 'package:metropay/utilities/loading.dart';
import './PaymentSelectionButton.dart';
import 'package:provider/provider.dart';

class AddMoneyButton extends StatefulWidget {
  @override
  _AddMoneyButtonState createState() => _AddMoneyButtonState();
}

class _AddMoneyButtonState extends State<AddMoneyButton> {

  final _formKey = GlobalKey<FormState>();

    String _currentName;
    double _currentbalance;
    String _currentboarding;
    String _currentdestination;

  double amount = 0.00;

  Widget _walletAmount() {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          _currentName = userData.name;
          _currentdestination = userData.destination;
          _currentboarding = userData.boarding;
          _currentbalance = userData.balance;

          return Card(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 15.0, 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 0.8,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 4,
                      color: Color(0xFF61A4F1),
                      margin: const EdgeInsets.only(left: 0.0, right: 190.0),
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Please enter amount' : null,
                      decoration: new InputDecoration(
                          hintText: "Enter Amount", fillColor: Colors.white),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => setState(() {
                        amount = double.parse(val);
                      }),
                    ),
                     SizedBox(height: 15.0),
                    RaisedButton(
                      elevation: 4.0,
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          _currentbalance = _currentbalance + amount;
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? snapshot.data.name,
                              _currentbalance ?? snapshot.data.balance,
                              _currentboarding ?? snapshot.data.boarding,
                              _currentdestination ?? snapshot.data.destination
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentSelectionButton()),
                          );
//                          Navigator.pop(context);
                        }
                      },
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
//        color: Colors.white,
                      child: Text(
                        'Add to wallet',
                        style: TextStyle(
//            color: Color(0xFF527DAA),
                          letterSpacing: 1.5,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        else{
          return Loading();
        }
      }
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
//                height: double.infinity,
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
                      _walletAmount(),
//                      SizedBox(height: 10.0),
//                      _addAmountBtn(),
//                      SizedBox(height: 10.0),
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
