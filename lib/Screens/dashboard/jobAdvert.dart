import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pathway/Models/Classes/jobs.dart';
import 'package:pathway/Models/Services/savedJobs_api.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Screens/dashboard/jobApplication.dart';
import 'package:pathway/Utils/Widgets/Animations.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobAdvert extends StatefulWidget {
  @override
  _JobAdvertState createState() => _JobAdvertState();
}

class _JobAdvertState extends State<JobAdvert> {
  // bool isButtonPressed = false;
  bool isButtonPressed = false;
  bool viewVisible = false;

  var slideDuration = 100;

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentJob = ModalRoute.of(context).settings.arguments;
    FavouriteJobs favourites = Provider.of<FavouriteJobs>(context);
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    var jobs = Provider.of<List<Jobs>>(context)
        .where((jobs) => currentJob.contains(jobs.jobTitle))
        .toList();
    String _launchUrl = jobs[0].jobUrl.toString();
    return Scaffold(
      backgroundColor: DarkColors.primaryColor,

      //Appbar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: FadeIn(
            delay: Duration(milliseconds: slideDuration),
            child: Text(
              "Job Advert",
              style: TextStyle(fontSize: 22),
            ),
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
            child: FadeIn(
              delay: Duration(milliseconds: slideDuration),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                ),
                color: DarkColors.primaryTextColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),

      //Main body
      body: SingleChildScrollView(
        child: Container(
          //page container
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //job container
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FadeIn(
                    delay: Duration(milliseconds: slideDuration),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: (viewVisible == false)
                          ? MediaQuery.of(context).size.height * 0.75
                          : MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        color: DarkColors.primaryColorDarker,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: DarkColors.secondaryTextColorDark,
                              blurRadius: 12)
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.only(top: 60),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              child: Text(
                                jobs[0].logo,
                                style: ThemeText.titleStyle.copyWith(
                                    color: (settings.colortheme == 'Dark')
                                        ? DarkColors.primaryTextColor
                                        : LightColors.primaryTextColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    delay: Duration(milliseconds: slideDuration),
                                      child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: (viewVisible == false)
                          ? MediaQuery.of(context).size.height * 0.6
                          : MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        color: DarkColors.primaryColorDark,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Job Title
                          Text(
                            currentJob,
                            style: TextStyle(
                                fontSize: 20, color: DarkColors.primaryTextColor),
                          ),

                          //Spacer
                          SizedBox(
                            height: 20,
                          ),

                          //Header - End Date, location, gradeReq, Category
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Icon(
                                          (Platform.isAndroid)
                                              ? Icons.location_on
                                              : CupertinoIcons.location_solid,
                                          size: 16,
                                          color: DarkColors.secondaryColor,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          jobs[0].location,
                                          style: ThemeText.bodyStyle12.copyWith(
                                              color: (settings.colortheme ==
                                                      'Dark')
                                                  ? DarkColors.primaryTextColor
                                                  : LightColors.primaryTextColor),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Row(children: <Widget>[
                                        Icon(
                                          (Platform.isAndroid)
                                              ? Icons.calendar_today
                                              : FontAwesomeIcons.calendar,
                                          size: 16,
                                          color: DarkColors.secondaryColor,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          jobs[0].endDate,
                                          style: ThemeText.bodyStyle12.copyWith(
                                              color: (settings.colortheme ==
                                                      'Dark')
                                                  ? DarkColors.primaryTextColor
                                                  : LightColors.primaryTextColor),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Icon(
                                          (Platform.isAndroid)
                                              ? FontAwesomeIcons.graduationCap
                                              : FontAwesomeIcons.graduationCap,
                                          size: 16,
                                          color: DarkColors.secondaryColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          jobs[0].gradeRequired,
                                          style: ThemeText.bodyStyle12.copyWith(
                                              color: (settings.colortheme ==
                                                      'Dark')
                                                  ? DarkColors.primaryTextColor
                                                  : LightColors.primaryTextColor),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Row(children: <Widget>[
                                        Icon(
                                          (Platform.isAndroid)
                                              ? FontAwesomeIcons.moneyBillAlt
                                              : FontAwesomeIcons.moneyBillAlt,
                                          size: 16,
                                          color: DarkColors.secondaryColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          jobs[0].category,
                                          style: ThemeText.bodyStyle12.copyWith(
                                              color: (settings.colortheme ==
                                                      'Dark')
                                                  ? DarkColors.primaryTextColor
                                                  : LightColors.primaryTextColor),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              //border
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: DarkColors.secondaryColor,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ))),
                              ),
                            ],
                          ),

                          //spacer
                          SizedBox(height: 20),

                          //Main Body
                          Text(
                            'Job Description',
                            style: TextStyle(
                                fontSize: 18, color: DarkColors.primaryTextColor),
                          ),

                          //spacer
                          SizedBox(height: 10),

                          Text(
                            (viewVisible == false)
                                ? jobs[0].description.substring(0, 591) + '...'
                                : jobs[0].description,
                            style: TextStyle(
                                fontSize: 14, color: DarkColors.primaryTextColor),
                          ),

                          //spacer
                          SizedBox(height: 10),

                          Center(
                            child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    viewVisible = !viewVisible;
                                  });
                                },
                                child: Text(
                                  (viewVisible == false)
                                      ? 'See More'
                                      : 'See less',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: DarkColors.primaryTextColor),
                                )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: DarkColors.secondaryColor,
                              width: 1,
                              style: BorderStyle.solid,
                            ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              FadeIn(
                delay: Duration(milliseconds: slideDuration),
                offset: Offset(0.0, 64.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 270,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      buttonColor: DarkColors.secondaryColor,
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        onPressed: () {
                          //checks if the current job has a url if not then returns the application process
                          if (jobs[0].jobUrl != '') {
                            _launchInApp(_launchUrl);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InJobApplication(),
                                settings: RouteSettings(
                                  arguments: currentJob,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Apply for job',
                          style: TextStyle(
                              fontSize: 20,
                              color: DarkColors.secondaryTextColorDark),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    ButtonTheme(
                      minWidth: 50,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      buttonColor: (favourites.savedJobs.contains(currentJob))
                          ? DarkColors.secondaryColor
                          : DarkColors.primaryColorDarker,
                      child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            if (favourites.savedJobs.contains(currentJob)) {
                              favourites.removeSavedJobs(currentJob);
                              setState(() {
                                isButtonPressed = !isButtonPressed;
                              });
                            } else {
                              favourites.addSavedJobs(currentJob);
                              setState(() {
                                isButtonPressed = !isButtonPressed;
                              });
                            }
                          },
                          child: Icon(
                            Icons.favorite,
                            color: DarkColors.primaryTextColor,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
