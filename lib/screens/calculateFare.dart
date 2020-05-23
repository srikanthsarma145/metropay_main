import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metropay/utilities/constants.dart';

class CalculateFareButton extends StatefulWidget {
  @override
  _CalculateFareButtonState createState() => _CalculateFareButtonState();
}

class _CalculateFareButtonState extends State<CalculateFareButton> {

  final List<String> stations = ['1', '2', '3', '4','5'];

  String boarding;
  String destination;
  String fare;

  Widget _boardingBtn(){
    return Container(
      child:Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Boarding Point',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
            value: boarding ?? '1',
            decoration: textInputDecoration,
            items: stations.map((station) {
              return DropdownMenuItem(
                value: station,
                child: Text('Station $station',
                  style: TextStyle(
                      color: Colors.black
                  ),),
              );
            }).toList(),
            onChanged: (val) => setState(() => boarding = val ),
          ),
        ],
      ),
    );
  }

  Widget _destinationBtn(){
    return Container(
      child:Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Destination Point',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
            value: destination ?? '1',
            decoration: textInputDecoration,
            items: stations.map((station) {
              return DropdownMenuItem(
                value: station,
                child: Text('Station $station',
                  style: TextStyle(
                      color: Colors.black
                  ),),
              );
            }).toList(),
            onChanged: (val) => setState(() => destination = val ),
          ),
        ],
      ),
    );
  }

  Widget _calculateBtn() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          elevation: 4.0,
          padding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
//                    color: Colors.pink[400],
          child: Text(
            'Calculate',
            style: TextStyle(letterSpacing: 1.5,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',),
          ),
          onPressed: () {
            setState(() {
             if(boarding!=destination){
               if(double.parse(boarding)>double.parse(destination)){
                 fare = ((double.parse(boarding)-double.parse(destination))*10).toString();
               }
               else{
                 fare = ((double.parse(destination)-double.parse(boarding))*10).toString();
               }
               Navigator.pop(context);
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
               Navigator.pop(context);
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
                        'Calculate Fare',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      _boardingBtn(),
                      SizedBox(height: 20.0,),
                      _destinationBtn(),
                      SizedBox(height: 20.0,),
                      _calculateBtn()
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

