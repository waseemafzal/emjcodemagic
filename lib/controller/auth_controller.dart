import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/mighty_exception.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/user_model.dart';
import 'package:emjay_global/view/screen/auth_screen/login_screen.dart';
import 'package:emjay_global/view/screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isRequestingHelp = false.obs;
  RxBool isLoggedIn = false.obs;
  Rx<User?> user = Rx(null);

  var username;
  var accesstoken;
  // ConnectivityResult _currentConnection = ConnectivityResult.none;

  // AuthController() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     print("Connection Changed :: ${result}");
  //     this._currentConnection = result;
  //   });
  // }
  String? deviceId;
  Future<String> getUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId =
          '${iosDeviceInfo.identifierForVendor}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId =
          '${androidDeviceInfo.serialNumber}:${androidDeviceInfo.id}'; // unique ID on Android
    }

    return deviceId.toString();
  }

  Future<void> saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', username);
    await prefs.setString('accesstoken', accesstoken);
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      username = prefs.getString('username') ?? '';
      accesstoken = prefs.getString('accesstoken') ?? '';
    }

    return isLoggedIn;
  }

  register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String mobile,
  }) async {
    try {
      isLoading(true);
      await getUniqueDeviceId();
      var response = await ApiHelper().postData('signup', {
        'first_name': firstname,
        'sur_name': lastname,
        'email': email,
        'password': password,
        'mobile': mobile,
        'devicetype': Platform.operatingSystem,
        'device_id': deviceId,
      });

      Get.to(() => LoginScreen());
      organoSnackBar(message: response['message']);
    } on MyExceptions catch (e) {
      organoSnackBar(message: e.toString());
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  forgotPassword({required String email}) async {
    try {
      isLoading(true);
      var response = await ApiHelper().postData('forgotPassword', {
        'email': email,
      });
      Get.to(() => LoginScreen());
      organoSnackBar(message: response['message']);
    } on MyExceptions catch (e) {
      organoSnackBar(message: e.toString());
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  // login({required String email, required String password}) async {
  //   try {
  //     isLoading(true);

  //     var response = await ApiHelper().postData('login', {
  //       'email': email,
  //       'password': password,
  //       'devicetype': 'android',
  //       'device_id': "sdkjlfkasdl23423",
  //       'social_type': 'normal',
  //     });

  //     // user.value = User.fromJson(response);
  //     // user.value!.password = password;
  //     organoSnackBar(message: response['message']);
  //     username = response['user']['name'];
  //     accesstoken = response['user']['access_token'];
  //     print(username);
  //     print(accesstoken);
  //     await saveLoginStatus();

  //     // await storeAuthData(user.value!.toJson());

  //     Get.offAll(() => HomeScreen());

  //     // if (await isFirstTimeLogin()) {
  //     //   Get.to(() => ChoosePackagePage());
  //     // }
  //   } on MyExceptions catch (e) {
  //     organoSnackBar(message: e.toString());
  //   } catch (e) {
  //     printError(info: e.toString());
  //     organoSnackBar(message: e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  login({required String email, required String password}) async {
    try {
      isLoading(true);
      await getUniqueDeviceId();
      var response = await ApiHelper().postData('login', {
        'email': email,
        'password': password,
        'devicetype': Platform.operatingSystem,
        'device_id': deviceId,
        'social_type': 'normal',
      });

      organoSnackBar(message: response['message']);
      username = response['user']['name'];
      username = response['user']['name'];
      username = response['user']['name'];
      username = response['user']['name'];
      username = response['user']['name'];
      username = response['user']['name'];
      accesstoken = response['user']['access_token'];
      print(username);
      print(accesstoken);

      // Save the login status in shared preferences
      await saveLoginStatus();

      Get.to(() => HomeScreen());
    } on MyExceptions catch (e) {
      organoSnackBar(message: e.toString());
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }

//   Future<bool> attemptLogin(
//       {required String email, required String password}) async {
//     await this.login(email: email, password: password);

//     if (user.value == null) return false;
//     return true;
//   }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    this.username = '';
    this.accesstoken = '';
    Get.offAll(() => LoginScreen());
  }

//   requestHelp({
//     required String requestType,
//     required String description,
//     String? successMessage,
//   }) async {
//     try {
//       if (_currentConnection == ConnectivityResult.bluetooth ||
//           _currentConnection == ConnectivityResult.none) {
//         final box = GetStorage();
//         final Position position = await _getGeoLocationPosition();
//         String divider = GetPlatform.isIOS ? '&' : '?';
//         final uri = Uri.parse(
//             'sms:${user.value!.sms_to}${divider}body=I have an ${requestType} emergency. Please send help asap!. Location is ${position.latitude}, ${position.longitude}');

//         if (await canLaunchUrl(uri)) {
//           launchUrl(uri);
//           return;
//         }
//       }
//       isRequestingHelp(true);
//       Position position = await _getGeoLocationPosition();
//       var response = await ApiHelper().postDataAuthenticated(
//         'requestHelp',
//         {
//           'request_type': requestType,
//           'description': description,
//           'latlon': '${position.latitude},${position.longitude}',
//         },
//       );
//       Get.back();
//       showMightySnackBar(message: successMessage ?? response['message']);
//     } catch (e) {
//       printError(info: e.toString());
//       showMightySnackBar(message: e.toString());
//     } finally {
//       isRequestingHelp(false);
//     }
//   }

  updateProfile({
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String address,
    required String password,
    required File? imageFile,
  }) async {
    try {
      isLoading(true);
      Map<String, dynamic> response = await ApiHelper().myPostDataAuthenticated(
        'updateProfile',
        {
          'first_name': firstname,
          'sur_name': lastname,
          'email': email,
          'mobile': phone,
          'address': address,
          'password': password,
        },
        imageFile,
      );
      if (response == 200) {
        organoSnackBar(message: response['message']);
        
      } else {
        organoSnackBar(message: response['message']);
      }
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  deleteMyAccount() async {
    try {
      isLoading(true);
      Map<String, dynamic> response =
          await ApiHelper().postDataAuthenticated('deleteAccount', {});
      organoSnackBar(message: response['message']);
      this.logOut();
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }

//   becomeReporter({required String value}) async {
//     isLoading(true);
//     try {
//       var reponse =
//           await ApiHelper().postDataAuthenticated('becomeGuestReporter', {
//         'guest_repoter': value.capitalize,
//       });
//       if (value.capitalize == 'Yes') {
//         showMightySnackBar(
//             message: "Congratulations! you are now a reporter.",
//             color: Colors.green);
//       } else {
//         showMightySnackBar(message: "You are no longer a reporter!");
//       }
//     } catch (e) {
//       printApiResponse(e.toString());
//       if (value.capitalize == 'Yes') {
//         showMightySnackBar(message: "You are already a reporter.");
//       } else {
//         showMightySnackBar(message: "You are no longer a reporter!");
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// Future<Position> _getGeoLocationPosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     await Geolocator.openLocationSettings();
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
}
