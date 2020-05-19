import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metropay/screens/PaymentSelectionButton.dart';

class AddMoneyButton extends StatefulWidget {
  @override
  _AddMoneyButtonState createState() => _AddMoneyButtonState();
}

class _AddMoneyButtonState extends State<AddMoneyButton> {
  final amountController = TextEditingController();

  var amount = 0.00;

  Widget _walletAmount() {
    return Card(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 15.0, 10.0),
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
            // SizedBox(height: 15.0),
            new TextFormField(
              controller: amountController,
              decoration: new InputDecoration(
                  hintText: "Enter Amount", fillColor: Colors.white),
              keyboardType: TextInputType.number,
            ),
        ],
        ),
      ),
    );
  }

  Widget _addAmountBtn() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () {
          //Navigator.pop(context,amountController);
          //Navigator.push(context, PaymentSelectionButton);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentSelectionButton()),
          );
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
                      _addAmountBtn(),
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
