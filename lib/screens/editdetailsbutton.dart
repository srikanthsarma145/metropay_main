import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditDetailsButton extends StatefulWidget {
  @override
  _EditDetailsButtonState createState() => _EditDetailsButtonState();
}

class _EditDetailsButtonState extends State<EditDetailsButton> {
  var username = 'Username';
  var fullName = 'fullName';
  var mobile = 9876543210;
  var emailId = 'example@123.com';


  Widget _userDetails() {
    return Card(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 15.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Edit Details',
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
            // SizedBox(height: 15.0),
            new TextFormField(
              decoration: new InputDecoration(
                  hintText: fullName, fillColor: Colors.white),
              keyboardType: TextInputType.text,
            ),
            new TextFormField(
              decoration: new InputDecoration(
                  hintText: mobile.toString(), fillColor: Colors.white),
              keyboardType: TextInputType.phone,
            ),
            new TextFormField(
              decoration: new InputDecoration(
                  hintText: emailId, fillColor: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveDetailsBtn() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
//        color: Colors.white,
        child: Text(
          'Save details',
          style: TextStyle(
//            color: Color(0xFF527DAA),
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
                      _userDetails(),
                      SizedBox(height: 10.0),
                      Text(
                        'Note: Click on the required options to edit the details. The previous data is visible on top of each field.',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,

                        ),
                        textAlign: TextAlign.justify,
                      ),
                      _saveDetailsBtn(),
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
