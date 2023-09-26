import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/auth_controller.dart';
import 'package:emjay_global/view/screen/auth_screen/login_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:emjay_global/view/widgets/password_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset("lib/view/assets/images/logo.png"),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Sign up",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyCustomTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Enter your first name";
                      } else {
                        return null;
                      }
                    },
                    myController: firstnameController,
                    myHint: "First Name",
                  ),
                  MyCustomTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Enter your last name";
                      } else {
                        return null;
                      }
                    },
                    myController: lastnameController,
                    myHint: "Last Name",
                  ),
                  MyCustomTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Mobile Number";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    myController: phoneController,
                    myHint: "Phone",
                  ),
                  MyCustomTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Email";
                      } else {
                        return null;
                      }
                    },
                    myController: emailController,
                    myHint: "Email",
                  ),
                  PasswordTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Password";
                      } else if (value.length < 6) {
                        return "Password is too short";
                      } else {
                        return null;
                      }
                    },
                    myController: passwordController,
                    myHint: "Password",
                    mySuffixIcon: _showPassword == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    obsure: _showPassword,
                    onClick: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  PasswordTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Password";
                      } else if (value.length < 6) {
                        return "Password is too short";
                      } else {
                        return null;
                      }
                    },
                    myController: confPasswordController,
                    myHint: "Confirm Password",
                    mySuffixIcon: _showPassword == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    obsure: _showPassword,
                    onClick: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ],
              ),
            ),

            const Text(
              "By signing up you are agreeing to our Terms and Conditions",
              style: TextStyle(
                fontSize: 11,
              ),
            ),

            Obx(() {
              return authController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : MyCustomButton(
                      title: "Sign Up",
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          authController.register(
                            firstname: firstnameController.text.trim(),
                            lastname: lastnameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            mobile: phoneController.text.trim(),
                          );
                        } else {
                          organoSnackBar(message: "Some Fields are Empty");
                        }
                      },
                    );
            }),
            // const SizedBox(
            //   height: 20,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account ? ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginScreen());
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
