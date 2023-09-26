import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:get/get.dart';

class HomeDataController extends GetxController {
  var isLoading = false.obs;
  int? paidInvoiceCount;
  int? unpaidInvoiceCount;
  int? receivedShipments;
  int? processingShipments;
  int? shippedShipments;
  int? cancelledShipments;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      var response = await ApiHelper().getData("homeData", {});

      if (response['status'] == 200) {
        paidInvoiceCount = response['data']['paidInvoiceCount'];
        unpaidInvoiceCount = response['data']['unpaidInvoiceCount'];
        receivedShipments = response['data']['receivedShipments'];
        processingShipments = response['data']['processingShipments'];
        shippedShipments = response['data']['shippedShipments'];
        cancelledShipments = response['data']['cancelledShipments'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    } finally {
      isLoading.value = false;
    }
  }
}
