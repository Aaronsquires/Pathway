import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pathway/Models/Classes/User.dart';
import 'package:pathway/Models/Classes/userData.dart';
import 'package:pathway/Models/Services/Database_api.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Screens/Accounts/editAccount.dart';
import 'package:pathway/Screens/Accounts/resume.dart';
import 'package:pathway/Screens/Settings/Settings.dart';
import 'package:pathway/Utils/Widgets/Loading.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pathway/Models/Services/Authentication_api.dart';

class SideMenu extends StatelessWidget {
  //  Edit Account Button Press
  void onEditAccountPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => AccountDetails()));

  //  Edit Account Button Press
  void onResumePagePressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => ResumePage()));

  //  Edit Account Button Press
  void onSettingsPagePressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => SettingsPage()));

  @override
  Widget build(BuildContext context) {
    var sideMenuWidth = MediaQuery.of(context).size.width;

    User user = Provider.of<User>(context);
    final AuthService _auth = AuthService();
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).usersdata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          var splitFullName =
              userData.fullName.split(" ").elementAt(0).toString();
          return Drawer(
            elevation: 25,
            child: Container(
              color: (settings.colortheme == 'Dark') ? DarkColors.primaryColorDarker : LightColors.primaryColor,
              width: sideMenuWidth / 2 * 0.2,
              child: Stack(
                children: <Widget>[
                  _buildBackground(sideMenuWidth, settings),
                  Column(
                    children: <Widget>[
                      DrawerHeader(
                        margin: EdgeInsets.only(left: sideMenuWidth * 0.08),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(

                        ),

                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration:  BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(3, 3))]),
                              child: CircleAvatar(
                                radius: 50,
                                
                                backgroundColor: DarkColors.secondaryColor,
                                child: CircleAvatar(
                                  radius: 47,
                                  backgroundImage:
                                      // AssetImage('assets/images/UserImage.png'),
                                      (userData.image != '') ? AssetImage('assets/images/UserImage.png') : NetworkImage(userData.image)
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              // Gets the users display name if it contains data it displays the displayName with an upper case first leter otherwise it displays "User"
                              (userData.fullName != '')
                                  ? splitFullName.substring(0, 1).toUpperCase() + splitFullName.substring(1)
                                  : userData.displayName.substring(0, 1).toUpperCase() + userData.displayName.substring(1),
                              style: TextStyle(
                                  color: (settings.colortheme == 'Dark') ?  DarkColors.primaryTextColor : LightColors.primaryTextColor,
                                  fontSize: 22),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            _buildDrawerItem(sideMenuWidth, settings,
                                icon: (Platform.isAndroid) ? Icons.person : CupertinoIcons.person_solid,
                                text: "Edit Account", onTap: () {
                              print("edit account");
                              onEditAccountPressed(context);
                            }),
                            SizedBox(
                              height: 20,
                            ),
                            _buildDrawerItem(sideMenuWidth, settings,
                                icon: (Platform.isAndroid) ? Icons.info : FontAwesomeIcons.infoCircle,
                                text: "Resume", onTap: () {
                              print("Resume");
                              onResumePagePressed(context);
                            }),
                            SizedBox(
                              height: 20,
                            ),
                            _buildDrawerItem(sideMenuWidth, settings,
                                icon: (Platform.isAndroid) ? Icons.settings : FontAwesomeIcons.cog,
                                text: "Settings", onTap: () {
                              print("Settings");
                              onSettingsPagePressed(context);
                            }),
                            SizedBox(
                              height: 20,
                            ),
                            _buildDrawerItem(sideMenuWidth, settings,
                              icon: (Platform.isAndroid) ? Icons.exit_to_app : Icons.exit_to_app,
                              text: "Logout", onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  if (Platform.isAndroid) {
                                    return AlertDialog(
                                      title: new Text("Alert"),
                                      content: new Text(
                                          "Are you sure you wish to logout?"),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("Close"),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          child: new Text("Logout"),
                                          onPressed: () async {
                                            await _auth.signOut();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                  if (Platform.isIOS) {
                                    return new CupertinoAlertDialog(
                                      title: new Text("Sign Out?"),
                                      content: new Text(
                                          "Are you sure you wish to logout?"),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: Text(
                                            "Cancel",
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          child: Text(
                                            "Logout",
                                          ),
                                          onPressed: () async {
                                            await _auth.signOut();
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  Widget _buildBackground(sideMenuWidth, settings) {
    return SizedBox(
      width: sideMenuWidth / 5,
      child: Container(
        color: (settings.colortheme == 'Dark') ? DarkColors.secondaryColor : LightColors.primaryColorLighter,
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //facebook
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebookSquare,
                  size: 30,
                  color:(settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor,
                ),
                onPressed: () {
                  print("Facebook");
                }),
            //Instagram
            SizedBox(height: 20),
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.instagramSquare,
                  size: 30,
                  color:(settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor,
                ),
                onPressed: () {
                  print("Instagram");
                }),
            //Twitter
            SizedBox(height: 20),
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitterSquare,
                  size: 30,
                  color:(settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor,
                ),
                onPressed: () {
                  print("Twitter");
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(sideMenuWidth, settings,
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: sideMenuWidth * 0.144),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(3, 3))]),
        child: Icon(
          icon,
          color: DarkColors.secondaryColor,
          size: 30,
        ),
      ),
      title: Container(
        child: Text(
          text,
          style: TextStyle(color:(settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor,),
        ),
      ),
      onTap: onTap,
    );
  }
}
