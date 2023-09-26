import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/my_shipment_model.dart';
import 'package:get/get.dart';

class MyShipmentController extends GetxController {
  RxBool isLoading = false.obs;

  MyShipmentModel? myShipmentModel;

  MyShipmentController(this.myShipmentModel);

  Future<void> fetchMyShipments() async {
    try {
      isLoading(true);
      var response = await ApiHelper().getData("getShopShipments");
      if (response['status'] == 200) {
        myShipmentModel = MyShipmentModel.fromJson(response);
        // organoSnackBar(message: response['messa']);
      } else {
        organoSnackBar(
            message: 'Error fetching invoices: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Data>? getMyShipments() {
    return myShipmentModel!.data;
  }
}
