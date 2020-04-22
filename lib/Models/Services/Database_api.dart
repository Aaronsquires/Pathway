import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pathway/Models/Classes/jobs.dart';
import 'package:pathway/Models/Classes/userData.dart';

class DatabaseService {
  //Get the users Data from Firebase Storage
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  Future<void> updateUserData(
      String image,
      String displayName,
      String email,
      String fullName,
      String phoneNumber,
      String university,
      String disciplin,
      String degreeType,
      String grade) async {
    return await userCollection.document(uid).setData({
      'image': image,
      'displayName': displayName,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'university': university,
      'disciplin': disciplin,
      'degreeType': degreeType,
      'grade': grade,
    });
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      displayName: snapshot.data['displayName'],
      degreeType: snapshot.data['degreeType'],
      email: snapshot.data['email'],
      fullName: snapshot.data['fullName'],
      phoneNumber: snapshot.data['phoneNumber'],
      university: snapshot.data['university'],
      disciplin: snapshot.data['disciplin'],
      grade: snapshot.data['grade'],
      image: snapshot.data['data'],
    );
  }
  Stream<UserData> get usersdata {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}

class FirestoreService {
  Firestore _db = Firestore.instance;
  var random = Random();

  Stream<List<Jobs>> getJobs() {
    return _db.collection('JobBoard')
      .orderBy('category')
      .snapshots()
      .map((snapshot) => snapshot.documents
      .map((document) => Jobs.fromJson(document.data))
      .toList());
  }

}