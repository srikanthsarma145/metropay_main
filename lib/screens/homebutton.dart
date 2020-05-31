import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:metropay/models/user.dart';
import 'package:metropay/services/database.dart';
import 'package:metropay/utilities/loading.dart';
import 'package:toast/toast.dart';
import 'dart:math';
import 'package:provider/provider.dart';


class HomeButton extends StatefulWidget {
  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {

  final List<String> stations = ['1', '2', '3', '4','5'];

  Random rnd = new Random();

  String _currentName;
  double _currentbalance;
  String _currentboarding;
  String _currentdestination;

  String boarding;
  String destination;
  String fare;


  String boardingPoint = 'Boarding Point';
  String destinationPoint = 'Destination Point';

  Widget _boardingPointBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          if(boardingPoint=='Boarding Point'){
            FlutterNfcReader.read().then((response) {
              print(response.content);
            });
            FlutterNfcReader.onTagDiscovered().listen((onData) {
              print(onData.id);
              print(onData.content);
            });

            boarding = rnd.nextInt(5).toString();
            while(double.parse(boarding)==0){
              boarding = rnd.nextInt(5).toString();
            }
            boardingPoint = 'Station ' +boarding;
          }
          else{
            return null;
          }
          setState(() {});
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
//        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.location_on,
              color: Colors.red,),
            Text(
              boardingPoint,
              style: TextStyle(
//            color: Color(0xFF478DE0),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _destinationPointBtn() {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            _currentName = userData.name;
            _currentbalance = userData.balance;
            _currentdestination = userData.destination;
            _currentboarding = userData.boarding;

            return  Container(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: (){
                  if(boardingPoint != 'Boarding Point'){
                    FlutterNfcReader.read().then((response) {
                      Toast.show("Working!!!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      print(response.content);
                    });
                    FlutterNfcReader.onTagDiscovered().listen((data) {
                      print(data.id);
                      print(data.content);
                    });
                    FlutterNfcReader.stop().then((response) {
                      print(response.status.toString());
                    });
                    destination = rnd.nextInt(5).toString();
                    while(double.parse(destination)==0){
                      destination = rnd.nextInt(5).toString();
                    }
                    destinationPoint='Station '+destination;
                  }
                  setState(() {});
                },
                onLongPress: () async{
                  if(destinationPoint!='Destination Point') {
                    boardingPoint = 'Boarding Point';
                    destinationPoint = 'Destination Point';
                    setState(() {

                      if(boarding!=destination){
                        if(double.parse(boarding)>double.parse(destination)){
                          fare = ((double.parse(boarding)-double.parse(destination))*10).toString();
                        }
                        else{
                          fare = ((double.parse(destination)-double.parse(boarding))*10).toString();
                        }
                        if(_currentbalance > double.parse(fare) && _currentbalance >0){
                          _currentbalance = (_currentbalance-double.parse(fare));
                          DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? snapshot.data.name,
                              _currentbalance ?? snapshot.data.balance,
                              _currentboarding ?? snapshot.data.boarding,
                              _currentdestination ?? snapshot.data.destination
                          );
                          showDialog(
                              context: context,
                              builder: (context)=> AlertDialog(
                                title: Text('Fare (Station $boarding -> Station $destination) : Rs.$fare'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onPressed: ()=>Navigator.pop(context,true),
                                  ),
                                ],
                              )
                          );
                        }
                        else{
                          showDialog(
                              context: context,
                              builder: (context)=> AlertDialog(
                                title: Text('Transaction Failed...Insufficient funds'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onPressed: ()=>Navigator.pop(context,true),
                                  ),
                                ],
                              )
                          );
                        }

                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (context)=> AlertDialog(
                              title: Text('Fare cant be calculated for same stations'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: ()=>Navigator.pop(context,true),
                                ),
                              ],
                            )
                        );
                      }
                    });
                  }
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),

//        color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.location_on,
                      color: Colors.green,),
                    Text(
                      destinationPoint,
                      style: TextStyle(
//            color: Color(0xFF478DE0),
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
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
                        'Note:\n 1. Please make sure that your phone consists of NFC feature and it is enabled.Press the buttons at boarding and destination points respectively to scan the details.\n 2. On scanning both boarding and destination points long press destination point button to complete the journey and calculate the fare.',
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