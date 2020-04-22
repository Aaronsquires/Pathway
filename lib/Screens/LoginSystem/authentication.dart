//imports
import 'package:flutter/material.dart';
import 'package:pathway/Screens/LoginSystem/Login.dart';
import 'package:pathway/Screens/LoginSystem/SignUp.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  //toggles the states between login page and signup page each time button onPressed 
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView); 
    } else {
      return SignUp(toggleView: toggleView);
    }
  }
}