import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/track_shipment_model.dart';
import 'package:get/get.dart';

class TrackShipmentController extends GetxController {
  RxBool isLoading = false.obs;
  TrackShipmentModel? _trackShipmentModel;
  TrackShipmentController(this._trackShipmentModel);
  // Fetch invoices from the API
  Future<void> trackShipment({required String trackNumber}) async {
    try {
      isLoading(true);
      final response =
          await ApiHelper().postDataAuthenticated("trackShipment", {
        "track_number": trackNumber,
      });
      if (response['status'] == 200) {
        // final jsonData = json.decode(response);
        _trackShipmentModel = TrackShipmentModel.fromJson(response);

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

  List<Data>? getTrackShipments() {
    return _trackShipmentModel!.data;
  }
}
