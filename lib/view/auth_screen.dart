import 'package:emjay_global/controller/auth_controller.dart';
import 'package:emjay_global/view/screen/auth_screen/login_screen.dart';
import 'package:emjay_global/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   Get.off(() => LoginScreen());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Get.find<AuthController>().checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You can show a loading indicator while checking the login status
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            // User is already logged in, navigate to HomeScreen
            return HomeScreen();
          } else {
            // User is not logged in, navigate to SignInScreen
            return LoginScreen();
          }
        }
      },
    );

    // Scaffold(
    //   body: Center(
    //     child: Image.asset("lib/view/assets/images/logo.png"),
    //   ),
    // );
  }
}
