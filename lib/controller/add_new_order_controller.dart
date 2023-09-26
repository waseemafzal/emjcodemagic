import 'dart:io';

import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/view/screen/home_screen.dart';
import 'package:get/get.dart';

class AddNewOrderController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> AddNewOrder({
    required String storeId,
    required String trackingId,
    required List<String> productNameList,
    required List<String> productQuantityList,
    required List<String> productPriceList,
    required String username,
    required String address,
    required String phone,
    required File? imageFile,
  }) async {
    try {
      isLoading(true);

      // Build the data to be sent to the API
      final Map<String, String> data = {
        'store_id': storeId,
        'tracking_no': trackingId,
        'name': productNameList.join(','),
        'price': productPriceList.join(','),
        'quantity': productQuantityList.join(','),
        'customer_name': username,
        'address': address,
        'mobile': phone,
      };

      Map<String, dynamic> response =
          await ApiHelper().myOrderPostDataAuthenticated(
        'saveShopOrder',
        data,
        imageFile,
      );
      if (response['status'] == 200) {
        organoSnackBar(message: response['message']);

        Get.offAll(() => const HomeScreen());
      }
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
