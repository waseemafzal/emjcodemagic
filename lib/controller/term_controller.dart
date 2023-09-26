import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:get/get.dart';

class TermConditionController extends GetxController {
  RxBool isLoading = false.obs;
  String? terms;

  Future<void> fetchTermsCondition() async {
    try {
      isLoading.value = true;
      var response = await ApiHelper().postDataAuthenticated('terms', {});
      if (response['status'] == 200) {
        terms = response['data'];
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
