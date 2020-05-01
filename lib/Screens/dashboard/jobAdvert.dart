import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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


  //Enables the launch url in app
  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        //takes the launch url from firebase
        url,
        forceSafariVC: true,
        //disables out of app webview
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

  @override
  Widget build(BuildContext context) {
    //set the current job as the argument from the gesturedetector
    final String currentJob = ModalRoute.of(context).settings.arguments;
    //access to favourites shared prefs
    FavouriteJobs favourites = Provider.of<FavouriteJobs>(context);
    //access to settings provider
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    //allows formating of numbers  
    final formatter = NumberFormat("##,###");
    //select the jobs from firebase where the job title is equal to the currentJob
    var jobs = Provider.of<List<Jobs>>(context)
        .where((jobs) => currentJob.contains(jobs.jobTitle))
        .toList();
    //set the launch url as the url saved to the job board
    String _launchUrl = jobs[0].jobUrl.toString();

    var job = jobs[0];


    return Scaffold(
      backgroundColor: (settings.colortheme == 'Dark')
          ? DarkColors.primaryColor
          : LightColors.primaryColor,

      //Appbar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: FadeIn(
            delay: Duration(milliseconds: slideDuration),
            child: Text(
              job.jobTitle,
              style: TextStyle(
                fontSize: 22,
                color: (settings.colortheme == 'Dark')
                    ? DarkColors.primaryTextColor
                    : LightColors.primaryTextColor,
              ),
            ),
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
            child: FadeIn(
              delay: Duration(milliseconds: slideDuration),
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
          ),
        ],
      ),

      //Main body
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            //Main Body
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: (settings.colortheme == 'Dark')
                        ? DarkColors.primaryColorDark
                        : LightColors.primaryColorLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    //Logo
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        color: (settings.colortheme == 'Dark')
                            ? DarkColors.primaryColorDarker
                            : LightColors.primaryColorLighter,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          //get the job logo
                          job.logo,
                          style: ThemeText.titleStyle.copyWith(
                            color: (settings.colortheme == 'Dark')
                                ? DarkColors.primaryTextColor
                                : LightColors.primaryTextColor,
                          ),
                        ),
                      ),
                    ),

                    //Spacer Bar
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: DarkColors.secondaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ))),
                    ),

                    //Spacer
                    SizedBox(height: 10),

                    //Detail row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20),
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
                                job.location,
                                style: ThemeText.bodyStyle12.copyWith(
                                    color: (settings.colortheme == 'Dark')
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
                                job.endDate,
                                style: ThemeText.bodyStyle12.copyWith(
                                    color: (settings.colortheme == 'Dark')
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
                                job.gradeRequired,
                                style: ThemeText.bodyStyle12.copyWith(
                                    color: (settings.colortheme == 'Dark')
                                        ? DarkColors.primaryTextColor
                                        : LightColors.primaryTextColor),
                              ),
                            ]),
                            SizedBox(
                              height: 14,
                            ),
                            Row(children: <Widget>[
                              Icon(
                                (settings.currency == 'Pounds')
                                    ? FontAwesomeIcons.poundSign
                                    : (settings.currency == 'Euros')
                                        ? FontAwesomeIcons.euroSign
                                        : FontAwesomeIcons.dollarSign,
                                size: 16,
                                color: DarkColors.secondaryColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                formatter.format((settings.currency == 'Pounds')
                                    ? job.pay
                                    : (settings.currency == 'Euros')
                                        ? job.pay * 1.15
                                        : job.pay * 1.25),
                                style: ThemeText.bodyStyle12.copyWith(
                                    color: (settings.colortheme == 'Dark')
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          children: [
                            //Header - End Date, location, gradeReq, Category
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //Description

                                //Main Body
                                Text(
                                  'Job Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: (settings.colortheme == 'Dark')
                                        ? DarkColors.primaryTextColor
                                        : LightColors.primaryTextColor,
                                  ),
                                ),

                                //spacer
                                SizedBox(height: 10),

                                Text(
                                  job.description,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: (settings.colortheme == 'Dark')
                                        ? DarkColors.primaryTextColor
                                        : LightColors.primaryTextColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //Spacer Between
            SizedBox(height: 20),

            //Apply and save button
            Row(
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
                      if (job.jobUrl != '') {
                        _launchInApp(_launchUrl);
                      } else {
                        //Sends the user to the application page along with the currentJob title
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
                        //Sets the job as saved to prefs or removes from prefs
                        if (favourites.savedJobs.contains(currentJob)) {
                          //removes the job from saved prefs
                          favourites.removeSavedJobs(currentJob);
                          setState(() {
                            //sets the colour back to dark
                            isButtonPressed = !isButtonPressed;
                          });
                        } else {
                          //Adds the job to saved prefs
                          favourites.addSavedJobs(currentJob);
                          setState(() {
                            //sets the colour to Highlighted
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
          ],
        ),
      ),
    );
  }
}