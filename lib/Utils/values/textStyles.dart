import 'package:flutter/widgets.dart';

abstract class ThemeText {
  //titles
  static const TextStyle titleStyle = TextStyle(
    fontFamily: "Helvetica",
    fontWeight: FontWeight.w400,
    fontSize: 22,
  );

  static const TextStyle titleStyle2 = TextStyle(
    fontFamily: "Helvetica",
    fontWeight: FontWeight.w400,
    fontSize: 18,
  ); 

    static const TextStyle titleStyle3 = TextStyle(
    fontFamily: "Helvetica",
    fontWeight: FontWeight.w400,
    fontSize: 16,
  ); 

  //Body Text
  static const TextStyle bodyStyle12 = TextStyle(
    fontFamily: "Helvetica",
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static const TextStyle bodyStyleSmallBold = TextStyle(
    fontFamily: "Helvetica",
    fontWeight: FontWeight.w800,
    fontSize: 14,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: "Helvetica",
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  //Button Text
  static const TextStyle buttonStyleLarge = TextStyle(
    fontFamily: "Helvetica",
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
}