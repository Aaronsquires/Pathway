import 'package:flutter/material.dart';
import 'package:pathway/Utils/values/values.dart';

class InJobApplication extends StatefulWidget {
  @override
  _InJobApplicationState createState() => _InJobApplicationState();
}

class _InJobApplicationState extends State<InJobApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkColors.primaryColor,

      //Appbar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text("In App Job Application", style: TextStyle(
            fontSize: 22
          ),),
        ),
        backgroundColor: DarkColors.primaryColorDarker,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(Icons.close, size: 30,),
              color: DarkColors.primaryTextColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),

      //Main body
      body: Center(
        child: Text("Apply for job")
      ),
    );
  }
}