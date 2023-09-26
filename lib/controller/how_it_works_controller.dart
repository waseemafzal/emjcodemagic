import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/how_it_works_model.dart';
import 'package:get/get.dart';

class HowItWorksController extends GetxController {
  RxBool isLoading = false.obs;
  HowItWorksModel? _howItWorksModel;
  HowItWorksController(this._howItWorksModel);

  // Fetch invoices from the API
  Future<void> fetchHowItWorks() async {
    try {
      isLoading(true);

      final response = await ApiHelper().getData("howitworks");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _howItWorksModel = HowItWorksModel.fromJson(response);

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

  List<Data>? getHowItWorks() {
    return _howItWorksModel!.data;
  }
}
