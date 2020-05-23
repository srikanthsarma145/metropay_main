import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metropay/models/mpayuser.dart';
import 'package:metropay/models/user.dart';
import 'package:metropay/utilities/loading.dart';
import './editdetailsbutton.dart';
import 'package:metropay/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:metropay/services/database.dart';

class ProfileButton extends StatefulWidget {


  final Mpayuser mpayuser;
  ProfileButton({ this.mpayuser });

  @override
  _ProfileButtonState createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {

  final AuthService _auth = AuthService();

  void _showEditPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: EditDetailsButton(),
      );
    });
  }


  Widget _userDetails() {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          return Card(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 15.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'User Details',
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 0.8,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(width: 50.0),
                      ButtonTheme(
                        minWidth: 10.0,
                        child: FlatButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            // elevation: 4.0,
                            onPressed: () => _showEditPanel(),
                            padding: EdgeInsets.all(0.0),
                            // color: Colors.white,
                            child: Icon(
                              Icons.edit,
                              size: 20.0,
                            )
                          // color: Colors.black,)
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(height: 4, color: Color(0xFF61A4F1),
                    margin: const EdgeInsets.only(left: 0.0, right: 190.0),),
                  SizedBox(height: 15.0),
                  Container(
                    height: 100,
                   child: Icon(Icons.account_box,
                   size: 100,),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Name    : '+userData.name+'\n\n'+'Balance : '+userData.balance.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 0.8,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ],
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

  Widget _logoutBtn() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () async{
//          Navigator.pop(context);
        await _auth.signOut();
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
//        color: Colors.white,
        child: Text(
          'Logout',
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
//                      SizedBox(height: 10.0),
                    _logoutBtn(),
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