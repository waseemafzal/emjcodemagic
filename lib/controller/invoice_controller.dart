import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/invoice_model.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  RxBool isLoading = false.obs;
  int? totalInvoice;
  int? totalAmount;
  InvoiceModel? invoiceModel;
  InvoiceController(this.invoiceModel);
  // Fetch invoices from the API
  Future<void> fetchInvoices() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("getInvoices");
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        invoiceModel = InvoiceModel.fromJson(response);

        totalInvoice = response['openCount'];
        totalAmount = response['totalAmount'];
        print(totalAmount);
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

  List<PaidInvoices>? getPaidInvoices() {
    return invoiceModel!.paidInvoices;
  }

  List<OpenInvoices>? getUnpaidInvoices() {
    return invoiceModel!.openInvoices;
  }
}
