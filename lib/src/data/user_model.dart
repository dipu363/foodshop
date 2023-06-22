import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String uRole;
  final String uName;
  final String email;
  final String phoneNo;
  final String city;
  final String password;

  // constructor
  const UserModel(
      {this.id,
      required this.uRole,
      required this.uName,
      required this.email,
      required this.phoneNo,
      required this.city,
      required this.password});

  toJson() {
    return {
      "Role": uRole,
      "FullName": uName,
      "Email": email,
      "PhoneNo": phoneNo,
      "City": city,
      "Password": password,
    };
  }

//this name constructor for data fetch from firestore
// DocumentSanpshot class comes from cloud firestore so import cloud firestore package
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
        id: document.id,
        uRole: data['Role'], // key name to be db column name
        uName: data['FullName'],
        email: data['Email'],
        phoneNo: data['PhoneNo'],
        city: data['City'],
        password: data['Password']);
  }
}
