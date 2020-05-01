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
    final formatter = NumberFormat("##,###");
    var jobs = Provider.of<List<Jobs>>(context)
        .where((jobs) => currentJob.contains(jobs.jobTitle))
        .toList();
    String _launchUrl = jobs[0].jobUrl.toString();
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
              jobs[0].jobTitle,
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
                          jobs[0].logo,
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
                                jobs[0].location,
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
                                jobs[0].endDate,
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
                                jobs[0].gradeRequired,
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
                                    ? jobs[0].pay
                                    : (settings.currency == 'Euros')
                                        ? jobs[0].pay * 1.15
                                        : jobs[0].pay * 1.25),
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
                                  jobs[0].description,
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
          ],
        ),
      ),
    );
  }
}

// body: SingleChildScrollView(
//         child: Container(
//           //page container
//           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
//           alignment: Alignment.topCenter,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               //job container
//               FadeIn(
//                 delay: Duration(milliseconds: slideDuration),
//                   child: Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   decoration: BoxDecoration(
//                     color: DarkColors.primaryColorDark,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[

//                       //Logo Section
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * 0.1,
//                         decoration: BoxDecoration(
//                           color: DarkColors.primaryColorDarker,
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
//                         ),
//                       ),

//                       //Border
//                       Container(
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                           color: DarkColors.secondaryColor,
//                           width: 1,
//                           style: BorderStyle.solid,
//                         ))),
//                       ),

//                       //Job Title
//                       Text(
//                         currentJob,
//                         style: TextStyle(
//                             fontSize: 20, color: DarkColors.primaryTextColor),
//                       ),

//                       //Spacer
//                       SizedBox(
//                         height: 20,
//                       ),

//                       //Header - End Date, location, gradeReq, Category
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               SizedBox(width: 10),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(children: <Widget>[
//                                     Icon(
//                                       (Platform.isAndroid)
//                                           ? Icons.location_on
//                                           : CupertinoIcons.location_solid,
//                                       size: 16,
//                                       color: DarkColors.secondaryColor,
//                                     ),
//                                     SizedBox(width: 6),
//                                     Text(
//                                       jobs[0].location,
//                                       style: ThemeText.bodyStyle12.copyWith(
//                                           color: (settings.colortheme ==
//                                                   'Dark')
//                                               ? DarkColors.primaryTextColor
//                                               : LightColors.primaryTextColor),
//                                     ),
//                                   ]),
//                                   SizedBox(
//                                     height: 14,
//                                   ),
//                                   Row(children: <Widget>[
//                                     Icon(
//                                       (Platform.isAndroid)
//                                           ? Icons.calendar_today
//                                           : FontAwesomeIcons.calendar,
//                                       size: 16,
//                                       color: DarkColors.secondaryColor,
//                                     ),
//                                     SizedBox(width: 6),
//                                     Text(
//                                       jobs[0].endDate,
//                                       style: ThemeText.bodyStyle12.copyWith(
//                                           color: (settings.colortheme ==
//                                                   'Dark')
//                                               ? DarkColors.primaryTextColor
//                                               : LightColors.primaryTextColor),
//                                     ),
//                                   ]),
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 40,
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(children: <Widget>[
//                                     Icon(
//                                       (Platform.isAndroid)
//                                           ? FontAwesomeIcons.graduationCap
//                                           : FontAwesomeIcons.graduationCap,
//                                       size: 16,
//                                       color: DarkColors.secondaryColor,
//                                     ),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       jobs[0].gradeRequired,
//                                       style: ThemeText.bodyStyle12.copyWith(
//                                           color: (settings.colortheme ==
//                                                   'Dark')
//                                               ? DarkColors.primaryTextColor
//                                               : LightColors.primaryTextColor),
//                                     ),
//                                   ]),
//                                   SizedBox(
//                                     height: 14,
//                                   ),
//                                   Row(children: <Widget>[
//                                     Icon(
//                                       (Platform.isAndroid)
//                                           ? FontAwesomeIcons.moneyBillAlt
//                                           : FontAwesomeIcons.moneyBillAlt,
//                                       size: 16,
//                                       color: DarkColors.secondaryColor,
//                                     ),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       jobs[0].category,
//                                       style: ThemeText.bodyStyle12.copyWith(
//                                           color: (settings.colortheme ==
//                                                   'Dark')
//                                               ? DarkColors.primaryTextColor
//                                               : LightColors.primaryTextColor),
//                                     ),
//                                   ]),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           //border
//                           Container(
//                             decoration: BoxDecoration(
//                                 border: Border(
//                                     bottom: BorderSide(
//                               color: DarkColors.secondaryColor,
//                               width: 1,
//                               style: BorderStyle.solid,
//                             ))),
//                           ),
//                         ],
//                       ),

//                       //spacer
//                       SizedBox(height: 20),

//                       //Main Body
//                       Text(
//                         'Job Description',
//                         style: TextStyle(
//                             fontSize: 18, color: DarkColors.primaryTextColor),
//                       ),

//                       //spacer
//                       SizedBox(height: 10),

//                       Text(
//                         (viewVisible == false)
//                             ? jobs[0].description.substring(0, 591) + '...'
//                             : jobs[0].description,
//                         style: TextStyle(
//                             fontSize: 14, color: DarkColors.primaryTextColor),
//                       ),

//                       //spacer
//                       SizedBox(height: 10),

//                       Container(
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                           color: DarkColors.secondaryColor,
//                           width: 1,
//                           style: BorderStyle.solid,
//                         ))),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(height: 20),
//               FadeIn(
//                 delay: Duration(milliseconds: slideDuration),
//                 offset: Offset(0.0, 64.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     ButtonTheme(
//                       minWidth: 270,
//                       height: 50,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       buttonColor: DarkColors.secondaryColor,
//                       child: RaisedButton(
//                         padding: EdgeInsets.all(10.0),
//                         onPressed: () {
//                           //checks if the current job has a url if not then returns the application process
//                           if (jobs[0].jobUrl != '') {
//                             _launchInApp(_launchUrl);
//                           } else {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => InJobApplication(),
//                                 settings: RouteSettings(
//                                   arguments: currentJob,
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                         child: Text(
//                           'Apply for job',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: DarkColors.secondaryTextColorDark),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 25,
//                     ),
//                     ButtonTheme(
//                       minWidth: 50,
//                       height: 50,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       buttonColor: (favourites.savedJobs.contains(currentJob))
//                           ? DarkColors.secondaryColor
//                           : DarkColors.primaryColorDarker,
//                       child: RaisedButton(
//                           padding: EdgeInsets.all(10.0),
//                           onPressed: () {
//                             if (favourites.savedJobs.contains(currentJob)) {
//                               favourites.removeSavedJobs(currentJob);
//                               setState(() {
//                                 isButtonPressed = !isButtonPressed;
//                               });
//                             } else {
//                               favourites.addSavedJobs(currentJob);
//                               setState(() {
//                                 isButtonPressed = !isButtonPressed;
//                               });
//                             }
//                           },
//                           child: Icon(
//                             Icons.favorite,
//                             color: DarkColors.primaryTextColor,
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
