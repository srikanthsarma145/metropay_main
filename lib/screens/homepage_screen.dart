import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './homebutton.dart';
import './walletbutton.dart';
import './mapbutton.dart';
import './profilebutton.dart';

class HomeScreen extends StatefulWidget {
//  final String userId;
//  HomeScreen({this.userId});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Future<bool> _onBackPressed(){
    return showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Do you really want to exit"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "No",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: ()=>Navigator.pop(context,false),
          ),
          FlatButton(
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: ()=>Navigator.pop(context,true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            HomeButton(),
            WalletButton(),
            MapButton(),
            ProfileButton(/*userId: widget.userId,*/),
//          ProfileScreen(userId: widget.userId,),

          ],
          onPageChanged: (int index) {
            setState(() {
              _currentTab = index;
            });
          },
          physics: NeverScrollableScrollPhysics(),

        ),
        bottomNavigationBar: CupertinoTabBar(

          currentIndex: _currentTab,
          onTap: (int index) {
            setState(() {
              _currentTab = index;
            });
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 1),
              curve: Curves.easeIn,
            );
          },
//        backgroundColor: Colors.white,
          activeColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 29.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet,
                size: 29.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.pin_drop,
                size: 29.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 29.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
