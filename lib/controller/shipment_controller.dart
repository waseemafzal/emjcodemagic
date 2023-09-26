import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/shipment_model.dart';
import 'package:get/get.dart';

class ShipmentController extends GetxController {
  RxBool isLoading = false.obs;
  ShipmentModel? _shipmentModel;
  ShipmentController(this._shipmentModel);
  // Fetch invoices from the API
  Future<void> fetchShipment() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("getShipments");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _shipmentModel = ShipmentModel.fromJson(response);

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

  List<Data>? getShipments() {
    return _shipmentModel!.data;
  }
}
