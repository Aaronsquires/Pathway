import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String uid;
  String displayName;
  String email;
  String fullName;
  String phoneNumber;
  String university;
  String disciplin;
  String degreeType;
  String grade;
  String image;

  UserData({this.displayName, this.disciplin, this.grade, this.degreeType, this.email, this.fullName, this.image, this.phoneNumber, this.university, this.uid});

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return UserData(
      uid: data['uid'],
      displayName: data['displayName'],
      degreeType: data['degreeType'],
      email: data['email'],
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber'],
      university: data['university'],
      disciplin: data['disciplin'],
      grade: data['grade'],
      image: data['data'],
      );
  }
}