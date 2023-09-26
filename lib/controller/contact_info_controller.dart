import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:get/get.dart';

class ContactInfoController extends GetxController {
  RxBool isLoading = false.obs;
  String? contactInfo;
  String? usaShippingInfo;

  Future<void> fetchContactInfo() async {
    try {
      isLoading.value = true;
      var response = await ApiHelper().getData('contactinfo', {});
      if (response['status'] == 200) {
        contactInfo = response['data'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUSAShippingInfo() async {
    try {
      isLoading.value = true;
      var response = await ApiHelper().getData('usashippinginfo', {});
      if (response['status'] == 200) {
        usaShippingInfo = response['data'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
