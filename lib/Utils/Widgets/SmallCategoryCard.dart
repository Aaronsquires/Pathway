import 'package:flutter/material.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Utils/values/values.dart';
import 'package:provider/provider.dart';

class SmallCategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  SmallCategoryCard({this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settings = Provider.of<SettingsProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.33,
      child: Card(
        shadowColor: Colors.black26,
        elevation: 1,
        color: (settings.colortheme == 'Dark')
            ? DarkColors.primaryColorDarker
            : LightColors.primaryColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
            child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.33,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: (settings.colortheme == 'Dark')
                    ? Colors.black45
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: (settings.colortheme == 'Dark')
                        ? DarkColors.primaryTextColor
                        : DarkColors.primaryTextColor),
                textAlign: TextAlign.center,
                
              ),
            )
          ],
        )),
      ),
    );
  }
}
