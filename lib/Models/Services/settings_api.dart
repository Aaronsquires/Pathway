import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String _colortheme;
  String _currency;

  SettingsProvider(){
    _colortheme = 'Dark';
    _currency = 'Pounds';
    loadPreferences();
  }

  //Getters
  String get colortheme => _colortheme;
  String get currency => _currency;

  //Setters
  void setcolorTheme(String colortheme){
    _colortheme = colortheme;
    notifyListeners();
    savePreferences();
  }

   void setCurrency(String currency){
    _currency = currency;
    notifyListeners();
    savePreferences();
  }


  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('colortheme', _colortheme);
    prefs.setString('currency', _currency);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String colortheme = prefs.getString('colortheme');
    String currency = prefs.getString('currency');  
    if (colortheme != null) setcolorTheme(colortheme);
    if (currency != null) setCurrency(currency);
  }
}