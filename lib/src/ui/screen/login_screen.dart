
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_manager/user_auth_controller.dart';
import '../util/app_colors.dart';
import '../util/style.dart';
import '../widget/common_edittext_field.dart';
import '../widget/common_elevated_button.dart';
import '../screen/get_start_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailVerifyController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<UserAuthController>(
            builder: (authController) {
          return Padding(
            padding: const EdgeInsets.all(36.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcom Back',
                      style: titleTextStyle,
                    ),
                    Text(
                      'Enter Email address nad password',
                      style: subtitleTextStyle,
                    ),
                    const SizedBox(height: 24),
                    CommonEditTextField(
                      controller: emailVerifyController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please Enter Valid Email Address';
                        } else {
                          return null;
                        }
                      },
                      hintext: 'Email Address',
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: passWordController,
                      obscureText: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please Enter your password ';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2))),
                    ),
                    const SizedBox(height: 16),
                   SizedBox(
                            width: double.infinity,
                            child: CommonElevatedButton(
                              title: 'Next',
                              onTap: () {

                                String email = emailVerifyController.text;
                                String password = passWordController.text;
                                if (_formKey.currentState!.validate()) {
                                 //authController.signOut();
                                  authController.loggedIn(email, password);
                                  emailVerifyController.text = '';
                                  passWordController.text = '';
                                }
                              },
                            )),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account',
                              style: subtitleTextStyle,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(const GetStartedScreen());
                                },
                                child: Text(
                                  'SignUp',
                                  style: subtitleTextStyle.copyWith(
                                      color: primaryColor),
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
