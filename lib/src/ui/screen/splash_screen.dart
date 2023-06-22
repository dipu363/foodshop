import 'package:flutter/material.dart';
import '../screen/login_screen.dart';

import '../util/app_colors.dart';
import '../util/style.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) async {
      Get.off(() => const LogInScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 300,
                        width: 300,
                        fit: BoxFit.fill,
                      )),

                ],
              )),
          const Column(
            children: [
              CircularProgressIndicator(
                color: primaryColor,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Version 1.0',
                  style: TextStyle(
                      fontSize: 12, color: grayColor, letterSpacing: 0.6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
