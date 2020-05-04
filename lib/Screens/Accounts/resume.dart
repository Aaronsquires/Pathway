import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pathway/Models/Services/Authentication_api.dart';
import 'package:pathway/Utils/Widgets/TextFields.dart';
import 'package:pathway/Utils/Widgets/Validators.dart';
import 'package:pathway/Utils/values/values.dart';

class ResumePage extends StatefulWidget {
  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: DarkColors.primaryColor,

      //Appbar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            "Upload CV",
            style: TextStyle(fontSize: 22),
          ),
        ),
        backgroundColor: DarkColors.primaryColorDarker,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
              ),
              color: DarkColors.primaryTextColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),

      //Main body
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload your CV into our database system. This helps to provide quick and easy applications",
                    style: ThemeText.bodyStyle
                        .copyWith(color: DarkColors.primaryTextColor),
                  ),
                  SizedBox(height: 50),

                  //Email - Logs in with the users email
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Choose File...',
                    ),
                    cursorColor: DarkColors.secondaryColor,
                    //gets the styling from TextStyles.dart
                    style: TextStyle(
                        color: DarkColors.textFormFieldTextColor, fontSize: 16),
                    //checks if the user has entereed data if not will return an error to Enter an Email
                    validator: EmailFieldValidator.validate,
                    //when the user inputs data the onChanged will set value data into the email variable
                    onChanged: (val) {},
                  ),
                  //spacing

                  SizedBox(height: screenHeight / 20),

                  Text(
                    "Allowed file types (doc, docx, pdf, txt)",
                    style: ThemeText.bodyStyle
                        .copyWith(color: DarkColors.primaryTextColor),
                  ),

                  SizedBox(height: screenHeight / 20),
                 Text(
                    "Any information provided is only viewable by the Pathway team. Any data is protected via our legal privacy policies - which can be viewed here",
                    style: ThemeText.bodyStyle
                        .copyWith(color: DarkColors.primaryTextColor),
                  ),
                  SizedBox(height: screenHeight / 20),

                  ButtonTheme(
                  minWidth: screenWidth,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  buttonColor: DarkColors.secondaryColor,
                  child: RaisedButton(
                    elevation: 15,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () async {
                      
                    },
                    child: Text(
                      'Upload CV',
                      style: TextStyle(
                          fontSize: 20,
                          color: DarkColors.secondaryTextColorDark),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
