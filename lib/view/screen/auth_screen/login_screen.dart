import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/auth_controller.dart';
import 'package:emjay_global/view/screen/auth_screen/forget_password_screen.dart';
import 'package:emjay_global/view/screen/auth_screen/sign_up_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:emjay_global/view/widgets/password_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());
  bool _showPassword = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // emailController.text = "demo@gmail.com";
    // passwordController.text = "12345678";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 140,
            ),
            Image.asset("lib/view/assets/images/logo.png"),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Log in",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyCustomTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
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
                        return "Please enter password";
                      } else if (value.length < 6) {
                        return "Your password is too short";
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
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () {
                return authController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyCustomButton(
                        title: "Login",
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            authController.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          } else {
                            organoSnackBar(message: "Some Fields are Empty");
                          }
                        },
                      );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => ForgetPasswordScreen(),
                );
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const SignUpScreen());
              },
              child: const Text(
                "Create Account",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
