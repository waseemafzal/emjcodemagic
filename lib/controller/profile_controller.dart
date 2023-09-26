import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  String? userId;
  String? firstname;
  String? lastname;
  String? address;
  String? email;
  String? phone;
  String? imageUrl;
  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      var response = await ApiHelper().postDataAuthenticated('profile', {});
      if (response['status'] == 200) {
        userId = response['user']['user_id'];
        firstname = response['user']['first_name'];
        lastname = response['user']['sur_name'];
        email = response['user']['email'];
        phone = response['user']['mobile'];
        address = response['user']['address'];
        imageUrl = response['user']['image'];
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
