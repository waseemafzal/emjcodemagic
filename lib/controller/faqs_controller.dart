import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/faqs_model.dart';
import 'package:get/get.dart';

class FaqsController extends GetxController {
  RxBool isLoading = false.obs;
  FaqsModel? _faqsModel;
  FaqsController(this._faqsModel);
  // Fetch invoices from the API
  Future<void> fetchFAQs() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("getFaqs");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _faqsModel = FaqsModel.fromJson(response);

        // totalInvoice = response['openCount'];
        // totalAmount = response['totalAmount'];
        // print(_notificationModel);
        print(response);
      } else {
        // Handle error if needed
        print('Error fetching Faqs: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Data>? getFaqs() {
    return _faqsModel!.data;
  }
}
