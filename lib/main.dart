import 'package:emjay_global/controller/auth_controller.dart';
import 'package:emjay_global/controller/country_state_city_controller.dart';
import 'package:emjay_global/controller/home_data_controller.dart';
import 'package:emjay_global/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(HomeDataController());
    Get.put(CountryStateCityController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // appBarTheme: AppBarTheme(
        //     color: const Color(0xff4268DF),
        //     titleTextStyle: TextStyle(
        //       color: Colors.white,
        //     )),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xff4268DF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4268DF)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
