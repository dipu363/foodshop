import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/src/ui/state_manager/profile_controller.dart';
import '/src/ui/state_manager/user_auth_controller.dart';
import '/src/ui/screen/splash_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GetXBindings(),
      title: 'Food Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class GetXBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserAuthController());
    Get.put(ProfileController());
  }
}

