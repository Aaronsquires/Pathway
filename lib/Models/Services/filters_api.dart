import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltersProvider with ChangeNotifier {
  // List<String> _category;
  String _grade;
  String _location;
  String _category;
  List<String> _filterChips;

  FiltersProvider(){
    // _category = ['Computing', 'Banking', 'Design', 'Education'];
    _grade = 'All';
    _location = 'All';
    _category = 'All';
    _filterChips = [];
    loadPreferences();
  }

  //Getters
  // List<String> get category => _category;
  String get grade => _grade;
  String get location => _location;
  String get category => _category;
  List<String> get filterChips => _filterChips;

  //Setters
  // void _setCategory(List<String> category){
  //   _category = category;
  //   notifyListeners();
  // }

  void setFilterChips(List<String> filterChips){
    _filterChips = filterChips;
    notifyListeners();
  }

  void setGrade(String grade) {
     _grade = grade;
    notifyListeners();
    savePreferences();
  }

  void setLocation(String location) {
    _location = location;
    notifyListeners();
    savePreferences();
  }

  void setCategory(String category) {
     _category = category;
    notifyListeners();
    savePreferences();
  }

  void addFilterChips(String filterChips){
    if (_filterChips.contains(filterChips) == false){
      _filterChips.add(filterChips);
      notifyListeners();
      savePreferences();
    }
  }

  void removeFilterChips(String filterChips){
    if (_filterChips.contains(filterChips) == true){
      _filterChips.remove(filterChips);
      notifyListeners();
      savePreferences();
    }
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setStringList('category', _category);
    prefs.setString('grade', _grade);
    prefs.setString('location', _location);
    prefs.setString('category', _category);
    prefs.setStringList('filterChips', _filterChips);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // List<String> category = prefs.getStringList('category');
    String grade = prefs.getString('grade');
    String location = prefs.getString('location');
    String category = prefs.getString('category');
    List<String> filterChips = prefs.getStringList('filterChips');
    if (category != null) setCategory(category);
    if (grade != null) setGrade(grade);
    if (location != null) setLocation(location);
    if (filterChips != null) setFilterChips(filterChips);
  }
}