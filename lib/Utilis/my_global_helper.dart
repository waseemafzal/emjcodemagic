import 'package:get/get.dart';

organoSnackBar({required String message}) {
  Get.showSnackbar(GetSnackBar(
    snackPosition: SnackPosition.BOTTOM,
    message: "${message}",
    duration: Duration(seconds: 3),
  ));
}

void printApiResponse(String text) {
  print('\x1B[33m$text');
}
