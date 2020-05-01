import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Screens/dashboard/Filters.dart';
import 'package:pathway/Screens/dashboard/savedJobs.dart';
import 'package:pathway/Utils/Widgets/Animations.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  //  Saved Jobs Button Press
  void onSavedJobsPressed(BuildContext context) =>
      Navigator.push(context, SlideRightRoute(page: SavedJobsList()));

  //  Saved Jobs Button Press
  void onFiltersPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => FiltersList()));

  void onFiltersPressedIOS(BuildContext context) => Navigator.push(
      context, CupertinoPageRoute(builder: (context) => FiltersList()));

  void onSavedJobsPressedIOS(BuildContext context) =>
      Navigator.push(context, SlideRightRoute(page: SavedJobsList()));

  @override
  Widget build(BuildContext context) {
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    if (Platform.isAndroid) {
      return Container(
        height: 75,
        padding: EdgeInsets.only(top: 10, bottom: 30),
        decoration: BoxDecoration(
            color: (settings.colortheme == 'Dark')
                ? DarkColors.primaryColorDarker
                : LightColors.primaryColorLighter,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(color: DarkColors.primaryColorDarker, blurRadius: 12)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: 40,
                color: DarkColors.secondaryColor,
              ),
              onPressed: () {
                print('onSavedJobsPressed');
                onSavedJobsPressed(context);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.filter_list,
                size: 40,
                color: DarkColors.secondaryColor,
              ),
              onPressed: () {
                print('onFiltersPressed');
                onFiltersPressed(context);
              },
            )
          ],
        ),
      );
    } else if (Platform.isIOS) {
      return Container(
        height: 75,
        padding: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
            color: (settings.colortheme == 'Dark')
                ? DarkColors.primaryColorDarker
                : LightColors.primaryColorLighter,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CupertinoButton(
              child: Icon(
                FontAwesomeIcons.solidHeart,
                size: 35,
                color: DarkColors.secondaryColor,
              ),
              onPressed: () {
                print('onSavedJobsPressed');
                onSavedJobsPressedIOS(context);
              },
            ),
            CupertinoButton(
              child: Icon(
                Icons.filter_list,
                size: 40,
                color: DarkColors.secondaryColor,
              ),
              onPressed: () {
                print('onFiltersPressed');
                onFiltersPressedIOS(context);
              },
            )
          ],
        ),
      );
    }
  }
}