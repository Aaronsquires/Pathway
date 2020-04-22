import 'package:flutter/material.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: (settings.colortheme == 'Dark')
          ? DarkColors.primaryColor
          : LightColors.primaryColor,

      //Appbar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            "Settings",
            style: TextStyle(
                fontSize: 22,
                color: (settings.colortheme == 'Dark')
                    ? DarkColors.primaryTextColor
                    : LightColors.primaryTextColor),
          ),
        ),
        backgroundColor: (settings.colortheme == 'Dark')
            ? DarkColors.primaryColorDarker
            : LightColors.primaryColorLighter,
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
              color: (settings.colortheme == 'Dark')
                  ? DarkColors.primaryTextColor
                  : LightColors.primaryTextColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),

      //Main body
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Theme',
                      style: ThemeText.titleStyle2.copyWith(
                        color: (settings.colortheme == 'Dark')
                            ? DarkColors.primaryTextColor
                            : LightColors.primaryTextColor,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: (settings.colortheme == 'Dark')
                          ? DarkColors.primaryColorDark
                          : LightColors.primaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        itemHeight: null,
                        isExpanded: true,
                        style: TextStyle(
                          color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor,
                        ),
                        dropdownColor: (settings.colortheme == 'Dark') ? DarkColors.primaryColorDark : LightColors.primaryColorLighter,
                        value: settingsProvider.colortheme,
                        onChanged: (String value) {
                          settingsProvider.setcolorTheme(value);
                        },
                        elevation: 10,
                        items: <String>['Dark', 'Light']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Currency',
                      style: ThemeText.titleStyle2.copyWith(
                        color: (settings.colortheme == 'Dark')
                            ? DarkColors.primaryTextColor
                            : LightColors.primaryTextColor,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: (settings.colortheme == 'Dark')
                          ? DarkColors.primaryColorDark
                          : LightColors.primaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        itemHeight: null,
                        isExpanded: true,
                        style: TextStyle(
                          color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor,
                        ),
                        dropdownColor: (settings.colortheme == 'Dark') ? DarkColors.primaryColorDark : LightColors.primaryColorLighter,
                        value: settingsProvider.currency,
                        onChanged: (String value) {
                          settingsProvider.setCurrency(value);
                        },
                        elevation: 10,
                        items: <String>['Pounds', 'Euros', 'Dollars']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
