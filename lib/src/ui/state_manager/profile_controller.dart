
import 'package:cloud_firestore/cloud_firestore.dart';
import '../state_manager/user_auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../data/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find<ProfileController>();


  final _db = FirebaseFirestore.instance;

  // create user
  Future<void> saveUserInfo(UserModel user) async {
    _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar(
            'Success',
            'Your account has been created.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(.1),
            colorText: Colors.green,
          ),
        )
        .catchError((onError) {
      print('  =========================${onError.toString()}');
       Get.snackbar('Failed!', ' ${onError.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(.1),
          colorText: Colors.red);
    });
  }

  // get single user information
  Future<UserModel> getUserInfo(String userId) async {
    final snapshot =
        await _db.collection('Users').where('Email', isEqualTo: userId).get();
    final userDetails = snapshot.docs
        .map((document) => UserModel.fromSnapshot(document))
        .single;
    return userDetails;
  }
  Future<UserModel> currentUserInfo() async {
    var user = UserAuthController.instance.firebaseUser.value;
    final snapshot =
        await _db.collection('Users').where('Email', isEqualTo: user!.email ).get();
    final userDetails = snapshot.docs
        .map((document) => UserModel.fromSnapshot(document))
        .single;
    return userDetails;
  }

  // get all users list
  Future<List<UserModel>> getUsers() async {
    final snapshot = await _db.collection('Users').get();
    final userDetails = snapshot.docs
        .map((document) => UserModel.fromSnapshot(document))
        .toList();
    return userDetails;
  }

  // update user details
  Future<void> updateUserInfo(UserModel user) async {
    await _db
        .collection('Users')
        .doc(user.id)
        .update(user.toJson())
        .whenComplete(() => null);
  }
}
