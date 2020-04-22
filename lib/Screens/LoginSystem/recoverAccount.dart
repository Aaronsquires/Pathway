import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pathway/Models/Services/Authentication_api.dart';
import 'package:pathway/Utils/Widgets/Loading.dart';
import 'package:pathway/Utils/Widgets/TextFields.dart';
import 'package:pathway/Utils/values/values.dart';

class RecoverAccount extends StatefulWidget {
  @override
  _RecoverAccountState createState() => _RecoverAccountState();
}

class _RecoverAccountState extends State<RecoverAccount> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print("Building Recover Account Page");
    var screenWidth = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                DarkColors.loginColorDarkGrey,
                DarkColors.loginColorLightGrey
              ], radius: 0.5)),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
                  child: Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              icon: Icon(
                                (Platform.isIOS)
                                    ? CupertinoIcons.back
                                    : Icons.arrow_back,
                                color: DarkColors.textFormFieldTextColor,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Recover Account",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: DarkColors.primaryTextColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Enter your e-mail address to reset your password",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: DarkColors.textFormFieldTextColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 150),
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
                      SizedBox(height: 150),
                      ButtonTheme(
                        minWidth: 270,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        buttonColor: DarkColors.secondaryColor,
                        child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                                
                              });
                              dynamic result = await _auth.resetUserPassword(email);
                              if (result == null) {
                                setState(
                                  () {
                                    loading = false;
                                    error = 'problem';
                                  },
                                );
                              }
                            }
                          },
                          child: Text(
                            "Recover Account",
                            style: TextStyle(
                                fontSize: 20,
                                color: DarkColors.secondaryTextColorDark,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Text(error),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
