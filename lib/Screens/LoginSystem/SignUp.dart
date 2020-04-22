import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pathway/Models/Services/Authentication_api.dart';
import 'package:pathway/Utils/Widgets/Loading.dart';
import 'package:pathway/Utils/Widgets/TextFields.dart';
import 'package:pathway/Utils/values/values.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String displayName = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  DarkColors.loginColorDarkGrey,
                  DarkColors.loginColorLightGrey
                ], radius: 0.5),
              ),

              //Signup Form
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screenHeight / 14.93),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: IconButton(
                          icon: Icon(
                            (Platform.isIOS)
                                ? CupertinoIcons.back
                                : Icons.arrow_back,
                            color: DarkColors.textFormFieldTextColor,
                            size: 30,
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: DarkColors.primaryTextColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Container(
                      width: screenWidth / 1.53,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: DarkColors.primaryColorDark,
                              blurRadius: 6.0,
                              spreadRadius: 2),
                        ],
                      ),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            (Platform.isIOS)
                                ? CupertinoIcons.mail
                                : Icons.email,
                            color: DarkColors.textFormFieldTextColor,
                            size: 30,
                          ),
                        ),
                        style: TextStyle(
                            color: DarkColors.textFormFieldTextColor,
                            fontSize: 16),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: screenWidth / 1.53,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: DarkColors.primaryColorDark,
                              blurRadius: 6.0,
                              spreadRadius: 2),
                        ],
                      ),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Display Name',
                          prefixIcon: Icon(
                            (Platform.isIOS)
                                ? CupertinoIcons.person
                                : Icons.person_outline,
                            color: DarkColors.textFormFieldTextColor,
                            size: 30,
                          ),
                        ),
                        style: TextStyle(
                            color: DarkColors.textFormFieldTextColor,
                            fontSize: 16),
                        validator: (val) => val.isEmpty ? 'display name' : null,
                        onChanged: (val) {
                          setState(() => displayName = val);
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: screenWidth / 1.53,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: DarkColors.primaryColorDark,
                              blurRadius: 6.0,
                              spreadRadius: 2),
                        ],
                      ),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              (Platform.isIOS)
                                  ? CupertinoIcons.padlock
                                  : Icons.lock_outline,
                              color: DarkColors.textFormFieldTextColor,
                              size: 30,
                            )),
                        style: TextStyle(
                            color: DarkColors.textFormFieldTextColor,
                            fontSize: 16),
                        obscureText: true,
                        validator: (val) =>
                            val.length < 6 ? 'Enter a password' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    SizedBox(height: 60.0),
                    ButtonTheme(
                      minWidth: 270,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      buttonColor: DarkColors.secondaryColor,
                      child: RaisedButton(
                        elevation: 15,
                        padding: EdgeInsets.all(10.0),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print('Logging Successful');
                            setState(
                              () => loading = true,
                            );
                            print(loading);
                            dynamic result = await _auth.registerUser(
                              email,
                              password,
                              displayName,
                            );
                            if (result == null) {
                              setState(() {
                                error = 'please supply valid email';
                                loading = false;
                                return CupertinoAlertDialog(
                                  content: Text(error),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {}, child: Text('ok'))
                                  ],
                                );
                              });
                              print(loading);
                            }
                          }
                        },
                        child: Text(
                          'Sign-up',
                          style: TextStyle(
                              fontSize: 20,
                              color: DarkColors.secondaryTextColorDark),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight / 5.8),
                    FlatButton(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an Account?',
                            style: TextStyle(
                              fontSize: 14,
                              color: DarkColors.textFormFieldTextColor,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 14,
                              color: DarkColors.textTertiaryColor,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        widget.toggleView();
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
