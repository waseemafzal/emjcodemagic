import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/rates_model.dart';
import 'package:get/get.dart';

class RateController extends GetxController {
  RxBool isLoading = false.obs;
  RatesModel? _ratesModel;
  RateController(this._ratesModel);
  // Fetch invoices from the API
  Future<void> fetchRates() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("getRates");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _ratesModel = RatesModel.fromJson(response);

        // totalInvoice = response['openCount'];
        // totalAmount = response['totalAmount'];
        // print(_notificationModel);
        print(response);
      } else {
        // Handle error if needed
        print('Error fetching rates: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Data>? getRates() {
    return _ratesModel!.data;
  }
}
