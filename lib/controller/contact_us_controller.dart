import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/contact_us_model.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  RxBool isLoading = false.obs;
  ContactUsModel? _contactUsModel;
  ContactUsController(this._contactUsModel);
  // Fetch invoices from the API
  Future<void> fetchContactUsData() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("getTickets");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _contactUsModel = ContactUsModel.fromJson(response);

        // totalInvoice = response['openCount'];
        // totalAmount = response['totalAmount'];
        // print(_notificationModel);
        print(response);
      } else {
        // Handle error if needed
        print('Error fetching messages: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Pending>? getPendMessages() {
    return _contactUsModel!.pending;
  }

  List<Closed>? getClosedMessages() {
    return _contactUsModel!.closed;
  }

  Future<void> sendMessage({
    required String message,
  }) async {
    try {
      isLoading(true);
      Map<String, dynamic> response = await ApiHelper().postDataAuthenticated(
        'openTicket',
        {
          'message': message,
        },
      );
      organoSnackBar(message: response['message']);
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
