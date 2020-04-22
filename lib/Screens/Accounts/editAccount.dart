import 'package:flutter/material.dart';
import 'package:pathway/Models/Classes/User.dart';
import 'package:pathway/Models/Classes/userData.dart';
import 'package:pathway/Models/Services/Database_api.dart';
import 'package:pathway/Utils/Widgets/Loading.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> universities = [
    'Nottingham Trent University',
    'University of Cambridge',
    'University of Nottingham',
    'University of Durham',
    'University of Lincoln'
  ];

  String _currentDisplayName;
  String _currentFullName;
  String _currentEmail;
  String _currentPhoneNumber;
  String _currentUniversity;
  String _currentDisciplin;
  String _currentDegreeType;
  String _currentGrade;
  String _currentImage;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).usersdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
                backgroundColor: DarkColors.primaryColor,
                //Appbar
                appBar: AppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Account Details",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  backgroundColor: DarkColors.primaryColorDarker,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(40))),
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
                    child: Column(
                      children: [
                        //User Image
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        _buildUserAvatar(),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        //Account Details
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 40),
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          color: DarkColors.primaryColorDark,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: DarkColors
                                                    .secondaryTextColorDark,
                                                blurRadius: 12)
                                          ]),
                                      padding: EdgeInsets.all(25),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Account Details',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: DarkColors
                                                    .primaryTextColor),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),

                                          //Display Name
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  DarkColors.primaryColorDarker,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0xff000000),
                                                    offset: Offset(0, 1),
                                                    blurRadius: 4)
                                              ],
                                            ),
                                            child: Stack(children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 15),
                                                    hintText: "Display Name",
                                                    hintStyle: TextStyle(
                                                        color: DarkColors
                                                            .textFormFieldTextColor,
                                                        fontSize: 18)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                initialValue:
                                                    userData.displayName,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: DarkColors
                                                        .textFormFieldTextColor),
                                                cursorColor: Colors.white,
                                                onChanged: (val) => setState(
                                                    () => _currentDisplayName =
                                                        val),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 14, 0, 0),
                                                child: Text(
                                                  "Display Name",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: DarkColors
                                                          .primaryColor),
                                                ),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),

                                          //Full Name
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: DarkColors
                                                    .primaryColorDarker,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: Stack(children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 15),
                                                    hintText: "Full Name",
                                                    hintStyle: TextStyle(
                                                        color: DarkColors
                                                            .textFormFieldTextColor,
                                                        fontSize: 18)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                initialValue: userData.fullName,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: DarkColors
                                                        .textFormFieldTextColor),
                                                cursorColor: Colors.white,
                                                onChanged: (val) => setState(
                                                    () =>
                                                        _currentFullName = val),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 14, 0, 0),
                                                child: Text(
                                                  "Full Name",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: DarkColors
                                                          .primaryColor),
                                                ),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),

                                          //Email
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: DarkColors
                                                    .primaryColorDarker,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: Stack(children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 15),
                                                    hintText: "Display Name",
                                                    hintStyle: TextStyle(
                                                        color: DarkColors
                                                            .textFormFieldTextColor,
                                                        fontSize: 18)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                initialValue: userData.email,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: DarkColors
                                                        .textFormFieldTextColor),
                                                cursorColor: Colors.white,
                                                onChanged: (val) => setState(
                                                    () => _currentEmail = val),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 14, 0, 0),
                                                child: Text(
                                                  "E-mail",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: DarkColors
                                                          .primaryColor),
                                                ),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),

                                          //Phone Number
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: DarkColors
                                                    .primaryColorDarker,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: Stack(children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 15),
                                                    hintText: "Phone Number",
                                                    hintStyle: TextStyle(
                                                        color: DarkColors
                                                            .textFormFieldTextColor,
                                                        fontSize: 18)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                initialValue: userData
                                                    .phoneNumber
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: DarkColors
                                                        .textFormFieldTextColor),
                                                cursorColor: Colors.white,
                                                onChanged: (val) => setState(
                                                    () => _currentPhoneNumber =
                                                        val),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 14, 0, 0),
                                                child: Text(
                                                  "Phone Number",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: DarkColors
                                                          .primaryColor),
                                                ),
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //spacer
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),

                                    //Education Details
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          color: DarkColors.primaryColorDark,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: DarkColors
                                                    .secondaryTextColorDark,
                                                blurRadius: 12)
                                          ]),
                                      padding: EdgeInsets.all(25),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Education Details',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: DarkColors
                                                    .primaryTextColor),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),

                                          //University
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: DarkColors
                                                    .primaryColorDarker,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: Stack(children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 15),
                                                    hintText: "University",
                                                    hintStyle: TextStyle(
                                                        color: DarkColors
                                                            .textFormFieldTextColor,
                                                        fontSize: 18)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                initialValue:
                                                    userData.university,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: DarkColors
                                                        .textFormFieldTextColor),
                                                cursorColor: Colors.white,
                                                onChanged: (val) => setState(
                                                    () => _currentUniversity =
                                                        val),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 14, 0, 0),
                                                child: Text(
                                                  "University",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: DarkColors
                                                          .primaryColor),
                                                ),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: DarkColors
                                                    .primaryColorDarker,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                hint: Text('Hint'),
                                                itemHeight: null,
                                                isExpanded: true,
                                                style: TextStyle(
                                                    color: DarkColors
                                                        .primaryTextColor),
                                                dropdownColor:
                                                    DarkColors.primaryColorDark,
                                                value: userData.disciplin,
                                                onChanged: (val) => setState(
                                                    () => _currentDisciplin = val),
                                                elevation: 10,
                                                items: <String>[
                                                  '',
                                                  'Computer Science',
                                                  'Teaching',
                                                  'Sales',
                                                  'Recruitment',
                                                  'Accounting',
                                                  'Design',
                                                  'Engineering',
                                                  'Legal'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: value,
                                                      child: Text(value));
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),
                                          //Degree Type
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: DarkColors
                                                    .primaryColorDarker,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: Stack(children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 15),
                                                    hintText: "Degree Type",
                                                    hintStyle: TextStyle(
                                                        color: DarkColors
                                                            .textFormFieldTextColor,
                                                        fontSize: 18)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                initialValue:
                                                    userData.degreeType,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: DarkColors
                                                        .textFormFieldTextColor),
                                                cursorColor: Colors.white,
                                                onChanged: (val) => setState(
                                                    () => _currentDegreeType =
                                                        val),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 14, 0, 0),
                                                child: Text(
                                                  "Degree Type",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: DarkColors
                                                          .primaryColor),
                                                ),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),

                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 3, bottom: 3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: DarkColors
                                                    .primaryColorDarker,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                hint: Text('Hint'),
                                                itemHeight: null,
                                                isExpanded: true,
                                                style: TextStyle(
                                                    color: DarkColors
                                                        .primaryTextColor),
                                                dropdownColor:
                                                    DarkColors.primaryColorDark,
                                                value: userData.grade,
                                                onChanged: (val) => setState(
                                                    () => _currentGrade = val),
                                                elevation: 10,
                                                items: <String>[
                                                  '',
                                                  'First',
                                                  '2:1',
                                                  '2:2',
                                                  'Third'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: value,
                                                      child: Text(value));
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),

                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          buttonColor: DarkColors.secondaryColor,
                          child: RaisedButton(
                            elevation: 10,
                            padding: EdgeInsets.all(10.0),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                        _currentImage ?? snapshot.data.image,
                                        _currentDisplayName ??
                                            snapshot.data.displayName,
                                        _currentEmail ?? snapshot.data.email,
                                        _currentFullName ??
                                            snapshot.data.fullName,
                                        _currentPhoneNumber ??
                                            snapshot.data.phoneNumber,
                                        _currentUniversity ??
                                            snapshot.data.university,
                                        _currentDisciplin ??
                                            snapshot.data.disciplin,
                                        _currentDegreeType ??
                                            snapshot.data.degreeType,
                                        _currentGrade ?? snapshot.data.grade);

                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Update Information',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: DarkColors.secondaryTextColorDark),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }

  Widget _buildUserAvatar({BuildContext context}) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            backgroundColor: DarkColors.secondaryColor,
            child: CircleAvatar(
              radius: 67,
              backgroundImage: AssetImage('assets/images/UserImage.png'),
            ),
          ),
          //Button
          Positioned(
            left: 73,
            top: 93,
            child: RaisedButton(
              onPressed: () {},
              shape: CircleBorder(),
              color: DarkColors.secondaryColor,
              child: Icon(
                Icons.camera_alt,
                color: DarkColors.primaryTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
