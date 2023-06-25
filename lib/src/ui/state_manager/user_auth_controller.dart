
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/src/ui/state_manager/profile_controller.dart';
import 'package:get/get.dart';

import '../screen/app_common_screen/home_screen.dart';
import '../screen/app_common_screen/login_screen.dart';

class UserAuthController extends GetxController {
  static UserAuthController get instance => Get.find<UserAuthController>();

  bool _userCreateProgress = false;
  bool get userCreateProgress => _userCreateProgress;

  late Rx<User?> firebaseUser;

  final _auth = FirebaseAuth.instance;

  @override
  void onReady()  {
    // user logged in or out
    firebaseUser = Rx<User?>(_auth.currentUser);
    // user would be notified
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _initialScreen);
    print('login---------onReady call cause got an event on firebase user would be notified --------');
  }

  _initialScreen(User? user)async{
    // this dart standard if condition checking


    // it is any language standard
    if (user == null) {
      print('login---------user null so login screen --------$user');
      Get.offAll(() => const LogInScreen());
    } else {
      String email = user.email.toString();
      print('login------call profile controller-----------$email');
      var profileController = Get.find<ProfileController>();
      var userinfo = await profileController.getUserInfo(email);
      print('login------user role found -----------${userinfo.uRole}');
      if (userinfo.uRole == 'Customer') {
        print('login------route customer dashboard-----------$email');
        Get.off(()=>const HomeScreen());
      } else {
        Get.off(()=>const HomeScreen());
        print('login----- sailor dashboard-----------$email');
      }
    }
  }

  void createUser(String email, String password, String userRole) async {
    _userCreateProgress = true;
    update();
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    if(firebaseUser.value != null){
      _userCreateProgress = false;
      update();
   /*   if (userRole == 'Customer') {
        //Get.off(() => const TeacherDashboard());
      } else {
       // Get.off(() => const StudentDashboard());
      }*/    print('login---------user create with --------${firebaseUser.value!.email}');
      Get.snackbar(
        'Success',
        'Account has been Success',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(.1),
        colorText: Colors.green,
      );

    }else{
      print('login---------user create fail with --------');
      Get.snackbar(
        'Failed',
        'Account Creation failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(.1),
        colorText: Colors.green,

      );
    }
  }

  Future<void> loggedIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('  ============logIn() success=============${_auth.currentUser!.email}');
    } catch (e) {

      print('  ============logIn() fail=============${e.toString()}');
      Get.snackbar('Failed!', ' ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(.1),
          colorText: Colors.red);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print('  ============SignOut() Success=============');
  }

}
