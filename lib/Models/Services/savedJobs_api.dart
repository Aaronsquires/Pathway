import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteJobs extends ChangeNotifier {
  List<String> _savedJobs;

  FavouriteJobs(){
    _savedJobs = [];
    loadPreferences();
  }

  //Getters
  List<String> get savedJobs => _savedJobs;


  //Setters
  void _setSavedJobs(List<String> savedJobs){
    _savedJobs = savedJobs;
    notifyListeners();
  }

  void addSavedJobs(String savedJobs){
    if (_savedJobs.contains(savedJobs) == false){
      _savedJobs.add(savedJobs);
      notifyListeners();
      savePreferences();
    }
  }

  void removeSavedJobs(String savedJobs){
    if (_savedJobs.contains(savedJobs) == true){
      _savedJobs.remove(savedJobs);
      notifyListeners();
      savePreferences();
    }
  }
  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedJobs', _savedJobs);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedJobs = prefs.getStringList('savedJobs');
    if (savedJobs != null) _setSavedJobs(savedJobs);
  }


}