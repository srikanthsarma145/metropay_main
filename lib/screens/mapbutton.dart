import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class MapButton extends StatefulWidget {
  @override
  _MapButtonState createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton> {

  Widget _metroMap() {
    return Card(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Map of Hyderabad Metro',
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
            SizedBox(height: 20.0),
            Container(
              height: 240.0,
              width: double.infinity,
              child: PhotoView(
                imageProvider: AssetImage('assets/hydmetro/HMRRouteMap-1.png'),
                minScale: PhotoViewComputedScale.contained*1,
                maxScale: PhotoViewComputedScale.contained*1,
              ),
            ),
          ],
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
//                height: double.infinity,
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
                      _metroMap(),
                      SizedBox(height: 10.0),
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
