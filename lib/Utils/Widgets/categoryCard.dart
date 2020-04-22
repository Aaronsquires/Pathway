import 'package:flutter/material.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  CategoryCard({this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.36,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
                boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(0, 3,), blurRadius: 6)]
      ),
      child: Card(
        color: (settings.colortheme == 'Dark') ? DarkColors.primaryColorDark : LightColors.primaryColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.123,
                ),
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  color: (settings.colortheme == 'Dark') ? DarkColors.primaryColorDarker : LightColors.primaryColorLight,
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.all(5),
                child: Hero(
                  tag: 'dash',
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 16, color: (settings.colortheme == 'Dark') ? DarkColors.primaryTextColor : LightColors.primaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
