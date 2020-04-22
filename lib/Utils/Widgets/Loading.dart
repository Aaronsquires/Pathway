import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pathway/Utils/values/colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkColors.primaryColorDarker,
      child: Center(
        child: SpinKitFadingCircle(
          color: DarkColors.secondaryColor,
          size: 50,
        ),
      ),
      
    );
  }
}

class OnPageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitFadingCircle(
          color: DarkColors.secondaryColor,
          size: 50,
        ),
      ),
    );
  }
}