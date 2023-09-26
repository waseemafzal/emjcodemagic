import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/view/screen/home_screen.dart';
import 'package:get/get.dart';

class InvoicePaymentController extends GetxController {
  RxBool isLoading = false.obs;
  Future<void> invoicePayment({
    required String cardNo,
    required String expMonth,
    required String expYear,
    required String cvcNo,
    required String invoiceId,
    required String amount,
  }) async {
    try {
      isLoading(true);

      final response = await ApiHelper().postDataAuthenticated(
        'payInvoice',
        {
          'card': cardNo,
          'exp_month': expMonth,
          'exp_year': expYear,
          'cvc': cvcNo,
          'invoice_id': invoiceId,
          'amount': amount,
        },
      );

      if (response['status'] == 200) {
        organoSnackBar(message: response['message']);
        Get.to(() => HomeScreen());
      } else if (response['status' == 204]) {
        organoSnackBar(message: response['message'] ?? 'An error occurred.');
      }
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: 'Payment failed: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
