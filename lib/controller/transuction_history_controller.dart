import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/transuction_history_model.dart';
import 'package:get/get.dart';

class TransuctionHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  TransuctionHistroyModel? _transuctionHistroyModel;
  TransuctionHistoryController(this._transuctionHistroyModel);

  Future<void> fetchTransuctionHistroy() async {
    try {
      isLoading(true);
      final response = await ApiHelper().getData("transactionHistory");
      if (response['status'] == 200) {
        _transuctionHistroyModel = TransuctionHistroyModel.fromJson(response);

        print(response);
      } else {
        // Handle error if needed
        print('Error fetching transuction history: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Data>? getTransuctionHistory() {
    return _transuctionHistroyModel!.data;
  }
}
