import 'package:firebase_auth/firebase_auth.dart';
import 'package:pathway/Models/Classes/User.dart';
import 'package:pathway/Models/Services/Database_api.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a user by their unique id or sets user as null
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // Sign in the user With Email and Password
  Future loginUser(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register the user to firebase with a displayName, email and password
  Future registerUser(String email, String password, String displayName) async {
    try {
      //create the users account
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = displayName;
      FirebaseUser user = authResult.user;
      //Create the users account information area. (image, displayName, email, fullName, phoneNumber, university, disciplin, degreeType, grade)
      await DatabaseService(uid: user.uid).updateUserData('', displayName, email, '', '', '', '', '', '');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Reset User Password
  Future resetUserPassword(String email) async {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}