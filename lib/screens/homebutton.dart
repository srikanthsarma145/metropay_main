import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:toast/toast.dart';

class HomeButton extends StatefulWidget {
  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {

//  bool _travelling = false;
//  var boardvalue;
//  var destinvalue;


  var boardingPoint = 'Boarding Point';
  var destinationPoint = 'Destination Point';

//  boardtoggling(_travelling){
//    if(_travelling){
//      _travelling = false;
//      return ;
//    }
//  }
//
//  destintoggling(_travelling){
//    if(_travelling==false){
//      _travelling = true;
//      return ;
//    }
//  }


  Widget _boardingPointBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: /*boardtoggling(_travelling)*/(){
          FlutterNfcReader.read().then((response) {
            print(response.content);
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
//        color: Colors.white,
        child: Text(
          boardingPoint,
          style: TextStyle(
//            color: Color(0xFF478DE0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _destinationPointBtn() {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: /*destintoggling(_travelling)*/(){
          FlutterNfcReader.read().then((response) {
            Toast.show("Working!!!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
//            print(response.content);
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),

//        color: Colors.white,
        child: Text(
          destinationPoint,
          style: TextStyle(
//            color: Color(0xFF478DE0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

//  Future<bool> _onBackPressed(){
//    return showDialog(
//      context: context,
//      builder: (context)=>AlertDialog(
//        title: Text("Do you really want to exit"),
//        actions: <Widget>[
//          FlatButton(
//            child: Text(
//              "No",
//              style: TextStyle(
//                fontSize: 18,
//              ),
//            ),
//            onPressed: ()=>Navigator.pop(context,false),
//          ),
//          FlatButton(
//            child: Text(
//              "Yes",
//              style: TextStyle(
//                fontSize: 18,
//              ),
//            ),
//            onPressed: ()=>Navigator.pop(context,true),
//          ),
//        ],
//      ),
//    );
//  }

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
                      SizedBox(height: 120.0),
                      _boardingPointBtn(),
//                      Text(
//                        'o\no\no\no',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 20.0,
//                        ),
//                      ),
                      SizedBox(height: 10.0),
                      _destinationPointBtn(),
                      SizedBox(height: 10.0),
                      Text(
                        'Note: Please make sure that your phone consists of NFC feature and it is enabled.Press the buttons at boarding and destination points respectively to scan the details.',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,

                        ),
                        textAlign: TextAlign.justify,
                      ),
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
