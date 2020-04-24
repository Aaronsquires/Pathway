import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pathway/Models/Services/Authentication_api.dart';
import 'package:pathway/Screens/LoginSystem/recoverAccount.dart';
import 'package:pathway/Utils/Widgets/Animations.dart';
import 'package:pathway/Utils/Widgets/Loading.dart';
import 'package:pathway/Utils/Widgets/TextFields.dart';
import 'package:pathway/Utils/values/values.dart';

class SignIn extends StatefulWidget {
  //ccalls the toggleview function in authentication on change to sign up
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //set screen height and width to the device 
  var screenHeight;
  var screenWidth;

  //set the authservice
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state - sets the values for the textfields to save to
  String email = '';
  String password = '';
  String error = '';


  //Button Press for Forget password
  void onRecoverAccountPressed(BuildContext context) => Navigator.push(context,FadeRouteBuilder(page: RecoverAccount()));


  //Creates the Error message dialog box
  Future _buildErrorDialog(BuildContext context, _message) {
    if (Platform.isAndroid) {
      return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
    } else {
    }
  }

  //Builds the Logo at the top
  _buildPathwayLogo() {
    return Image(
      image: AssetImage(
        'assets/images/PathwayLogo.png',
      ),
      //resize the image based on the height
      fit: BoxFit.fitHeight,
      //set the height to the MediaQuery height of the device
      height: MediaQuery.of(context).size.height / 4.48,
    );
  }

  @override
  Widget build(BuildContext context) {
    //set screen height and width to the device 
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    //if loading is set to true then it will return the loading screen - otherwise it will return the scaffold
    return loading ? Loading() : Scaffold(
      //Background container
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight / 44.8, horizontal: screenWidth / 8.28),
          //sets height to the Max height of the screen
          height: screenHeight,
          //Adds the radial gradient
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              DarkColors.loginColorDarkGrey,
              DarkColors.loginColorLightGrey
            ], radius: 0.5),
          ),

          //Login the user using the Authentication_api.dart Future Login
          child: Form(
            //sets the form key - allows for grouping of validation
            key: _formKey,
            child: Column(
              children: <Widget>[
                //Spacer
                SizedBox(height: screenHeight / 9.9),

                //Image Logo at top of Login
                _buildPathwayLogo(),

                //Spacer
                SizedBox(height: screenHeight / 35),
                
                //Error message - if the login returns an error message it will be displayed here
                Text(
                  error,
                  style: TextStyle(
                    color: DarkColors.error,
                  ),
                ),

                //spacing
                SizedBox(height: screenHeight / 35),

                //Email - Logs in with the users email
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
                      //Sets the icon depending on the App Platform 
                      prefixIcon: Icon(
                        (Platform.isIOS) ? CupertinoIcons.mail : Icons.email,
                        color: DarkColors.textFormFieldTextColor,
                        size: 30,
                      ),
                    ),
                    //gets the styling from TextStyles.dart
                    style: TextStyle(
                        color: DarkColors.textFormFieldTextColor,
                        fontSize: 16),              
                    //checks if the user has entereed data if not will return an error to Enter an Email
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    //when the user inputs data the onChanged will set value data into the email variable
                    onChanged: (val) {setState(() => email = val);},
                  ),
                ),

                //spacing
                SizedBox(height: screenHeight / 35.84),

                //Email - Logs in with the users password
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: DarkColors.primaryColorDark,
                          blurRadius: 6.0,
                          spreadRadius: 2),
                    ],
                  ),
                  width: screenWidth / 1.53,
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Password',
                        prefixIcon: Icon(
                        (Platform.isIOS) ? CupertinoIcons.padlock : Icons.lock_outline,
                        color: DarkColors.textFormFieldTextColor,
                          size: 30,
                        )),
                    style: TextStyle(
                        color: DarkColors.textFormFieldTextColor,
                        fontSize: 16),
                    validator: (val) =>
                        val.length < 6 ? 'Enter a password' : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                ),
                SizedBox(height: screenHeight / 17.92),

                //Login Button - calls business logic of signing into firebase as authenticated user
                ButtonTheme(
                  minWidth: screenWidth / 1.53,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  buttonColor: DarkColors.secondaryColor,
                  child: RaisedButton(
                    elevation: 15,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(
                          () => loading = true,
                        );
                        print(loading);
                        dynamic result = await _auth.loginUser(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Email or Password incorrect please try again';
                            loading = false;
                          });
                          print(loading);
                          return _buildErrorDialog(context, error);
                        }
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20,
                          color: DarkColors.secondaryTextColorDark),
                    ),
                  ),
                ),

                //spacing
                SizedBox(height: screenHeight / 35.84),

                //Calls the account recovery page
                FlatButton(
                  onPressed: () {
                    this.onRecoverAccountPressed(context);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: DarkColors.textFormFieldTextColor,
                        fontSize: 14),
                  ),
                ),
                SizedBox(height: screenHeight / 13),

                //Login Button - calls business logic of signing into firebase as authenticated user
                FlatButton(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Dont have an Account?',
                        style: TextStyle(
                          fontSize: 14,
                          color: DarkColors.textFormFieldTextColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Sign-Up',
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
                SizedBox(height: screenHeight / 44.8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
