import 'package:flutter/material.dart';
import 'package:pathway/Utils/values/values.dart';

const textInputDecoration = InputDecoration(
  filled: true,
  fillColor: DarkColors.primaryColorDarker,
  border: InputBorder.none,
  hintText: "DisplayName",
  hintStyle: TextStyle(color: DarkColors.textFormFieldTextColor, fontSize: 16),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: DarkColors.secondaryColor, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color: DarkColors.primaryColorDarker, width: 2),
  ),
);
