import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metropay/utilities/constants.dart';
import './signup_screen.dart';
import './forgetpassword_screen.dart';
import './homepage_screen.dart';
import 'package:toast/toast.dart';
import 'package:metropay/services/auth.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  // final usernameController = TextEditingController();
  // final passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
//  String user,pass;
  String eMail = '';
  String passWord = '';
  String error='';

//  @override
//  void dispose() {
//    // Clean up the controller when the widget is disposed.
//    usernameController.dispose();
//    passwordController.dispose();
//    super.dispose();
//  }

  Widget _buildEmailIdTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget>[
                  Text(
                    'Email',
                    style: kLabelStyle,
                  ),
                  SizedBox(height: 10.0),
                  Container(
//          key: _formKey,
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val){
                        setState(() => eMail = val);
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your Email',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Password',
                    style: kLabelStyle,
                  ),
                  SizedBox(height: 10.0),
                  Container(
//          key: _formKey,
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      // controller: passwordController,
                      obscureText: true,
                      onChanged: (val){
                        setState(() => passWord = val);
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your Password',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                ]
            )
        )
      ],
    );
  }

  // Widget _buildMobileNumTF() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Mobile Number',
  //         style: kLabelStyle,
  //       ),
  //       SizedBox(height: 10.0),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: kBoxDecorationStyle,
  //         height: 60.0,
  //         child: TextField(
  //           controller: usernameController,
  //           keyboardType: TextInputType.phone,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontFamily: 'OpenSans',
  //           ),
  //           decoration: InputDecoration(
  //             border: InputBorder.none,
  //             contentPadding: EdgeInsets.only(top: 14.0),
  //             prefixIcon: Icon(
  //               Icons.phone,
  //               color: Colors.white,
  //             ),
  //             hintText: 'Enter your Mobile Number',
  //             hintStyle: kHintTextStyle,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

//  Widget _buildPasswordTF() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          'Password',
//          style: kLabelStyle,
//        ),
//        SizedBox(height: 10.0),
//        Container(
//          key: _formKey,
//          alignment: Alignment.centerLeft,
//          decoration: kBoxDecorationStyle,
//          height: 60.0,
//          child: TextFormField(
//            validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
//            // controller: passwordController,
//            obscureText: true,
//            onChanged: (val){
//              setState(() => passWord = val);
//            },
//            style: TextStyle(
//              color: Colors.white,
//              fontFamily: 'OpenSans',
//            ),
//            decoration: InputDecoration(
//              border: InputBorder.none,
//              contentPadding: EdgeInsets.only(top: 14.0),
//              prefixIcon: Icon(
//                Icons.vpn_key,
//                color: Colors.white,
//              ),
//              hintText: 'Enter your Password',
//              hintStyle: kHintTextStyle,
//            ),
//            keyboardType: TextInputType.text,
//          ),
//        ),
//      ],
//    );
//  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgetScreen()),
          );
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () async{
          if(_formKey.currentState.validate()){
            dynamic result = await _auth.signInWithEmailAndPassword(eMail, passWord);
            if(result == null) {
              setState(() {
                error = 'incorrect email or password';
                Toast.show(error, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              });
            }
          }

//          if ((user == eMail) && (pass == passWord)) {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => HomeScreen(/*userId: userName,*/)),
//            );
//          }
//          // ignore: unrelated_type_equality_checks
//          else if((user == "") && (pass == "")){
//            Toast.show("Enter Username and Password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
//          }
//          else if((user == "") && (pass != "")){
//            Toast.show("Enter Username", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
//          }
//          else if((user != "") && (pass == "")){
//            Toast.show("Enter Password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
//          }
//          else{
//            Toast.show("Incorrect Username or Password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
//          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
//        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
//            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
//                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
//                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
                height: double.infinity,
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
                    vertical: 140.0,
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
                      _buildEmailIdTF(),
//                      SizedBox(height: 30.0),
//                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignUpBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
