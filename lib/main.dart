/* 
Pathway - Aaron Squires - N0748944 - Dissertation
*/

//Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pathway/Models/Classes/User.dart';
import 'package:pathway/Models/Services/Authentication_api.dart';
import 'package:pathway/Models/Services/filters_api.dart';
import 'package:pathway/Models/Services/savedJobs_api.dart';
import 'package:pathway/Models/Services/settings_api.dart';
import 'package:pathway/Screens/LoginSystem/authentication.dart';
import 'package:pathway/Models/Services/Database_api.dart';
import 'package:pathway/Screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

//main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Locks the screen to portrait mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      // calls the MultiProvider
      Providers(),
    );
  });
}

//Initialise the Providers - allows for all widgets built under the MultiProvider to have access to them
class Providers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirestoreService _db = FirestoreService();
    return MultiProvider(
      providers: [
        //Settings Provider - allows for access into the settings shared preferences
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        //Filters Provider - allows for access into the Filters shared preferences
        ChangeNotifierProvider(create: (context) => FiltersProvider()),
        //Favourite Jobs Provider - allows for access into the Saved Jobs shared Preferences
        ChangeNotifierProvider(create: (context) => FavouriteJobs()),
        //get the jobBoard from firebase
        StreamProvider(create: (BuildContext context) => _db.getJobs()),
      ],
      child: App(),
    );
  }
}

//Initialse the App giving access to the Authentication Service to login
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        //sends the value to the Root of the application
        home: Root(),
      ),
    );
  }
}

//Root of the application - Checks if the User has already logged in
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //sets the user from User Provider
    final user = Provider.of<User>(context);
    if (user == null) {
      //Checks if the user has any data connected
      return Authentication(); //if there isnt a user connected to the provider then return Authentication service
    } else {
      return Dashboard(); //If there is already a user set in the User Provider then return the user to the dashboard
    }
  }
}
