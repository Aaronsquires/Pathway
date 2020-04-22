import 'package:flutter/material.dart';
import 'package:pathway/Screens/LoginSystem/authentication.dart';
import 'package:pathway/Utils/values/values.dart';

class EntryScreen extends StatelessWidget {

  //  Get Started Button Press
  void onGetStartedPressed(BuildContext context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Authentication()));

  //  Get Started Button Press
  void onNoAccountPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => Authentication()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          //Background Image Asset from EntryScreenImg
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/EntryScreenImg.png'),
                    fit: BoxFit.cover)),
          ),

          //Buttons to Get started
          Positioned(
            left: MediaQuery.of(context).size.width / 12,
            bottom: MediaQuery.of(context).size.height / 8,
            child: Column(
              children: <Widget>[
                //Login Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.83,
                  height: 60,
                  child: RaisedButton(
                    onPressed: () => this.onGetStartedPressed(context),
                    color: DarkColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "Login",
                      style: ThemeText.buttonStyleLarge,
                    ),
                  ),
                ),

                //Sign-up Button
                FlatButton(
                    onPressed: () => this.onNoAccountPressed(context),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Dont have an Account?",
                          style: ThemeText.bodyStyle12,
                        ),
                        SizedBox(width: 3),
                        Text(
                          "Sign-up",
                          style: ThemeText.bodyStyleSmallBold,
                        ),
                      ],
                    )),
                // Text('Width = ${MediaQuery.of(context).size.height}')
              ],
            ),
          )
        ],
      ),
    );
  }
}
