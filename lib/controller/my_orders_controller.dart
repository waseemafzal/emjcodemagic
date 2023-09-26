import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/my_orders_model.dart';
import 'package:get/get.dart';

class MyOrdersController extends GetxController {
  RxBool isLoading = false.obs;
  int? totalInvoice;
  int? totalAmount;
  MyOrderModel? _myOrderModel;
  MyOrdersController(this._myOrderModel);
  // Fetch invoices from the API
  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("getShopOrders");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _myOrderModel = MyOrderModel.fromJson(response);

        // totalInvoice = response['openCount'];
        // totalAmount = response['totalAmount'];
        // print(totalAmount);
        print(response);
      } else {
        // Handle error if needed
        print('Error fetching invoices: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Pending>? getPendingOrders() {
    return _myOrderModel!.pending;
  }

  List<Received>? getReceivedOrders() {
    return _myOrderModel!.received;
  }

  List<Onhold>? getOnHoldOrders() {
    return _myOrderModel!.onhold;
  }

  List<Shipped>? getShippedOrders() {
    return _myOrderModel!.shipped;
  }

  List<Refused>? getRefusedOrders() {
    return _myOrderModel!.refused;
  }

  List<Missing>? getMissingOrders() {
    return _myOrderModel!.missing;
  }

  List<Packed>? getPackedOrders() {
    return _myOrderModel!.packed;
  }

  List<PartialReceived>? getPartialReceivedOrders() {
    return _myOrderModel!.partialReceived;
  }
}
