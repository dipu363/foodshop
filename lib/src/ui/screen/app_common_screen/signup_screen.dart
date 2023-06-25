
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/user_model.dart';
import '../../state_manager/profile_controller.dart';
import '../../state_manager/user_auth_controller.dart';
import '../../util/app_colors.dart';
import '../../util/style.dart';
import '../../widget/common_edittext_field.dart';
import '../../widget/common_elevated_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.userRole}) : super(key: key);
  final String userRole;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  fit: BoxFit.fill,

                ),
                const SizedBox(height: 8),
                Text(
                  'Sign Up ',
                  style: titleTextStyle,
                ),
                const SizedBox(height: 4),
                Text('get started with us with your details',
                    style: subtitleTextStyle),
                const SizedBox(height: 24),
                CommonEditTextField(
                  controller: nameTextController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter your full name';
                    } else {
                      return null;
                    }
                  },
                  hintext: 'Full Name',
                ),
                const SizedBox(height: 16),
                CommonEditTextField(
                  controller: emailTextController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter Valid Email Address';
                    } else {
                      if (!value!.contains('@')) {
                        return 'Please Enter Valid Email Address with "@"';
                      } else {
                        return null;
                      }
                    }
                  },
                  hintext: 'Email Address',
                ),
                const SizedBox(height: 16),
                CommonEditTextField(
                  controller: mobileTextController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter Valid mobile number';
                    } else {
                      return null;
                    }
                  },
                  hintext: 'Mobile',
                ),
                const SizedBox(height: 16),
                CommonEditTextField(
                  controller: cityTextController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter your current city ';
                    } else {
                      return null;
                    }
                  },
                  hintext: 'Current City',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passTextController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'please type minimum 6 digit password';
                    } else {
                      if (value.length < 6) {
                        return 'please type minimum 6 digit password';
                      } else {
                        return null;
                      }
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
                Text(
                  'keep noted your email and password for log in next time,  thank you.',
                  style: subtitleTextStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                GetBuilder<UserAuthController>(builder: (authController) {
                  return authController.userCreateProgress
                      ? const CircularProgressIndicator()
                      : CommonElevatedButton(
                          title: 'Submit',
                          onTap: () {
                            String email = emailTextController.text;
                            String password = passTextController.text;
                            if (_formKey.currentState!.validate()) {

                              Get.find<UserAuthController>()
                                  .createUser(email, password, widget.userRole);
                              authController.loggedIn(email, email);

                              var userdata = UserModel(
                                  uRole: widget.userRole,
                                  uName: nameTextController.text,
                                  email: emailTextController.text,
                                  phoneNo: mobileTextController.text,
                                  city: cityTextController.text,
                                  password: passTextController.text
                              );
                              ProfileController.instance.saveUserInfo(userdata);
                              nameTextController.text = '';
                              emailTextController.text = '';
                              mobileTextController.text = '';
                              cityTextController.text = '';
                              passTextController.text = '';


                            }
                          });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
