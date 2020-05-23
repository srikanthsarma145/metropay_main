import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metropay/models/user.dart';
import 'package:metropay/services/database.dart';
import 'package:metropay/utilities/constants.dart';
import 'package:metropay/utilities/loading.dart';
import 'package:provider/provider.dart';

class EditDetailsButton extends StatefulWidget {
  @override
  _EditDetailsButtonState createState() => _EditDetailsButtonState();
}

class _EditDetailsButtonState extends State<EditDetailsButton> {

  final _formKey = GlobalKey<FormState>();

    String _currentName;
    double _currentbalance;
    String _currentboarding;
    String _currentdestination;

  Widget _nameTF() {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;
          _currentbalance = userData.balance;
          _currentdestination = userData.destination;
          _currentboarding = userData.boarding;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: kLabelStyle,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
//          key: _formKey,
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextFormField(
                    initialValue: userData.name,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                      elevation: 4.0,
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
//                    color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(letterSpacing: 1.5,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? snapshot.data.name,
                              _currentbalance ?? snapshot.data.balance,
                              _currentboarding ?? snapshot.data.boarding,
                              _currentdestination ?? snapshot.data.destination
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),
                ),
              ],
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
//               height: double.infinity,
//                width: double.infinity,
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
//                width: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Edit Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _nameTF(),
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

