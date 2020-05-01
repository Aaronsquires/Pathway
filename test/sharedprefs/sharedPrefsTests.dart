import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  String _grade = 'grade';
  String _location = 'location';
  String _category = 'category';
  String _colortheme = 'theme';
  String _currency = 'currency';

  test('Test prefs 1', () async {
    await setupPreferences(_grade, 'grade');
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_grade);
    expect(value, 'grade');
  });

  test('test prefs 2', () async {
    await setupPreferences(_location, 'location');
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_location);
    expect(value, 'location');
  });

  test('test prefs 3', () async {
    await setupPreferences(_category, 'category');
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_category);
    expect(value, 'category');
  });

  test('test prefs 4', () async {
    await setupPreferences(_colortheme, 'theme');
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_colortheme);
    expect(value, 'theme');
  });

  test('test prefs 5', () async {
    await setupPreferences(_currency, 'currency');
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_currency);
    expect(value, 'currency');
  });

}

Future setupPreferences(String key, String value) async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{'flutter.' + key: value});
  final preferences = await SharedPreferences.getInstance();
  await preferences.setString(key, value);
}

