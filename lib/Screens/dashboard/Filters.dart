import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pathway/Models/Services/filters_api.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class FiltersList extends StatefulWidget {
  @override
  _FiltersListState createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  @override
  Widget build(BuildContext context) {
    var filters = Provider.of<FiltersProvider>(context);
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    // var currentValue = '';
    // var previousValue = '';
    List<String> chips = [filters.grade, filters.category, filters.location];
    return Scaffold(
      backgroundColor: (settings.colortheme == 'Dark')
          ? DarkColors.primaryColor
          : LightColors.primaryColor,

      //Appbar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            "Filters",
            style: TextStyle(
              fontSize: 22,
              color: (settings.colortheme == 'Dark')
                  ? DarkColors.primaryTextColor
                  : LightColors.primaryTextColor,
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
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List<Widget>.generate(chips.length, (int index) {
                    return Chip(
                      label: Text(
                        chips[index],
                        style: TextStyle(
                          color: (settings.colortheme == 'Dark')
                              ? DarkColors.primaryTextColor
                              : LightColors.primaryTextColor,
                        ),
                      ),
                      deleteIconColor: DarkColors.secondaryColor,
                      onDeleted: () {
                        (chips[index] == filters.category)
                            ? filters.setCategory('All')
                            : (chips[index] == filters.grade)
                                ? filters.setGrade('All')
                                : filters.setLocation('All');
                      },
                      backgroundColor: (settings.colortheme == 'Dark')
                          ? DarkColors.primaryColorDark
                          : LightColors.primaryColorLight,
                    );
                  })),
            ),
          ),
          SizedBox(
            height: 25,
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
                    'Work Preferences',
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
                      hint: Text('Hint'),
                      itemHeight: null,
                      isExpanded: true,
                      style: TextStyle(
                        color: (settings.colortheme == 'Dark')
                            ? DarkColors.primaryTextColor
                            : LightColors.primaryTextColor,
                      ),
                      dropdownColor: (settings.colortheme == 'Dark')
                          ? DarkColors.primaryColorDark
                          : LightColors.primaryColorLighter,
                      value: filters.category,
                      onChanged: (String value) {
                        filters.setCategory(value);
                        Fluttertoast.showToast(
                            msg: "Filtered jobs by $value",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: DarkColors.loginColorDarkGrey,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      },
                      elevation: 10,
                      items: <String>[
                        'All',
                        'Education',
                        'Engineering',
                        'Computing',
                        'Banking',
                        'Design'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 10.0,
          ),

          //Grade Select
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
                    'Grade',
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
                      isExpanded: true,
                      style: TextStyle(
                        color: (settings.colortheme == 'Dark')
                            ? DarkColors.primaryTextColor
                            : LightColors.primaryTextColor,
                      ),
                      dropdownColor: (settings.colortheme == 'Dark')
                          ? DarkColors.primaryColorDark
                          : LightColors.primaryColorLighter,
                      //sets the default value to the value stored in filters grade
                      value: filters.grade,
                      // changes the value to the new string pressed from the list of items
                      onChanged: (String value) {
                        //sets the grade variable to the new value
                        filters.setGrade(value);
                        //Shows a toast dialog at the bottom of the screen reasuring the user
                        Fluttertoast.showToast(
                            msg: "Filtered jobs by grade: $value",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: DarkColors.loginColorDarkGrey,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      },
                      elevation: 10,
                      //the items to be shown in the dropdown menu
                      items: <String>['All', 'First', '2:1', '2:2', 'Third']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Grade Select
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
                    'Location',
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
                      // isExpanded: true,

                      style: TextStyle(
                        color: (settings.colortheme == 'Dark')
                            ? DarkColors.primaryTextColor
                            : LightColors.primaryTextColor,
                      ),
                      dropdownColor: (settings.colortheme == 'Dark')
                          ? DarkColors.primaryColorDark
                          : LightColors.primaryColorLighter,
                      value: filters.location,
                      onChanged: (String value) {
                        filters.setLocation(value);
                        Fluttertoast.showToast(
                            msg: "Filtered jobs by $value",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: DarkColors.loginColorDarkGrey,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      },
                      elevation: 10,
                      items: <String>[
                        'All',
                        'Bedfordshire',
                        'Bath',
                        'Berkshire',
                        'Bristol',
                        'Buckinghamshire',
                        'Cambridge',
                        'Cheshire',
                        'Cornwall',
                        'Cumbria',
                        'Derbyshire',
                        'Devon',
                        'Dorset',
                        'Durham',
                        'East Riding of Yorkshire',
                        'East Sussex',
                        'Essex',
                        'Gloucestershire',
                        'Greater Manchester',
                        'Hampshire',
                        'Hereford',
                        'Worcester',
                        'Hertford',
                        'Hertfordshire',
                        'Isle of Man',
                        'Isle of Wight',
                        'Kent',
                        'Lancashire',
                        'Leicestershire',
                        'Lincolnshire',
                        'London',
                        'Merseyside',
                        'Middlesex',
                        'Norfolk',
                        'North Yorkshire',
                        'Northamptonshire',
                        'Northumberland',
                        'Nottingham',
                        'Nottinghamshire',
                        'Oxfordshire',
                        'Rutland',
                        'Shropshire',
                        'Somerset',
                        'South Yorkshire',
                        'Staffordshire',
                        'Suffolk',
                        'Surrey',
                        'Tyne and Wear',
                        'Warwickshire',
                        'West Midlands',
                        'West Sussex',
                        'West Yorkshire',
                        'Wiltshire'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
