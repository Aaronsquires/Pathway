import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JobCard extends StatelessWidget {
  final String logo;
  final String title;
  final String date;
  final String location;
  final String grade;
  final int pay;

  JobCard(
      {this.logo, this.title, this.date, this.grade, this.location, this.pay});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    final formatter = NumberFormat("##,###");
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
            color: (settings.colortheme == 'Dark') ? DarkColors.primaryColorDark : LightColors.primaryColorLight,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(0, 3,), blurRadius: 6)]),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 94,
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: (settings.colortheme == 'Dark') ? DarkColors.primaryColorDarker : LightColors.primaryColorLighter,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Center(
                    child: AutoSizeText(
                      logo,
                      maxLines: 1,
                      style: ThemeText.titleStyle2.copyWith(
                           color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor),
                    ),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                color: DarkColors.secondaryColor,
                width: 1,
                style: BorderStyle.solid,
              ))),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: ThemeText.titleStyle3.copyWith(
                           color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Icon(
                              (Platform.isAndroid) ? Icons.location_on : CupertinoIcons.location_solid,
                              size: 16,
                              color: DarkColors.secondaryColor,
                            ),
                            SizedBox(width: 6),
                            Text(
                              location,
                              style: ThemeText.bodyStyle12.copyWith(
                                color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor),
                            ),
                          ]),
                          SizedBox(
                            height: 14,
                          ),
                          Row(children: <Widget>[
                            Icon(
                              (Platform.isAndroid) ? Icons.calendar_today : FontAwesomeIcons.calendar,
                              size: 16,
                              color: DarkColors.secondaryColor,
                            ),
                            SizedBox(width: 6),
                            Text(
                              date,
                              style: ThemeText.bodyStyle12.copyWith(
                                color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor),
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Icon(
                              (Platform.isAndroid) ? FontAwesomeIcons.graduationCap : FontAwesomeIcons.graduationCap,
                              size: 16,
                              color: DarkColors.secondaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              grade,
                              style: ThemeText.bodyStyle12.copyWith(
                                color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor),
                            ),
                          ]),
                          SizedBox(
                            height: 14,
                          ),
                          Row(children: <Widget>[
                            Icon(
                              (settings.currency == 'Pounds') ? FontAwesomeIcons.poundSign : (settings.currency == 'Euros') ? FontAwesomeIcons.euroSign : FontAwesomeIcons.dollarSign,
                              size: 16,
                              color: DarkColors.secondaryColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              formatter.format(
                                (settings.currency == 'Pounds') ? pay : (settings.currency == 'Euros') ? pay * 1.15 : pay * 1.25
                              ),
                              style: ThemeText.bodyStyle12.copyWith(
                                color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
