import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;
  int? totalInvoice;
  int? totalAmount;
  NotificationModel? _notificationModel;
  NotificationController(this._notificationModel);
  // Fetch invoices from the API
  Future<void> fetchNotification() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("getNotifications");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _notificationModel = NotificationModel.fromJson(response);

        // totalInvoice = response['openCount'];
        // totalAmount = response['totalAmount'];
        print(_notificationModel);
        print(response);
      } else {
        // Handle error if needed
        print('Error fetching notification: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Data>? getNotification() {
    return _notificationModel!.data;
  }
}
