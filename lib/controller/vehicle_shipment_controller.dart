import 'dart:io';

import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/view/screen/home_screen.dart';
import 'package:get/get.dart';

class VehicleShipmentController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> vehicleShipmentOrders({
    required String shipperName,
    required String shipmentType,
    required String shipperPhone,
    required String shipperAddress,
    required String shipperState,
    required String shipperCity,
    required String requestPickup,
    required String pickUpLocation,
    required String requestInsurance,
    required String deliverType,
    required String consigneeName,
    required String consigneeAddress,
    required String consigneePhone,
    required String itemDescription,
    required String consigneeCountry,
    required String consigneeState,
    required String consigneeCity,
    required String quantity,
    required String length,
    required String width,
    required String height,
    required String packageWeight,
    required String carriageValue,
    required String shipmentFrom,
    required String shipmentTo,
    required String shipmentDate,
    required File? imageFile,
    required List<String> vehicleDescriptions,
    required List<String> vinNumbers,
    required List<String> purchaseCosts,
    required List<String> preferenceCompany,
  }) async {
    try {
      isLoading(true);

      // Build the data to be sent to the API
      final Map<String, String> data = {
        'shipper_name': shipperName,
        'shipment_type': shipmentType,
        'shipper_phone': shipperPhone,
        'shipper_address': shipperAddress,
        'shipper_state': shipperState,
        'shipper_city': shipperCity,
        'request_pickup': requestPickup,
        'pickup_location': pickUpLocation,
        'request_insurance': requestInsurance,
        'delivery_type': deliverType,
        'consignee_name': consigneeName,
        'consignee_address': consigneeAddress,
        'consignee_phone': consigneePhone,
        'item_description': itemDescription,
        'consignee_country': consigneeCountry,
        'consignee_state': consigneeState,
        'consignee_city': consigneeCity,
        'quantity': quantity,
        'length': length,
        'width': width,
        'height': width,
        'package_weight': packageWeight,
        'carriage_value': carriageValue,
        'shipment_from': shipmentFrom,
        'shipment_to': shipmentTo,
        'shipment_date': shipmentDate,
        'vehicle_description': vehicleDescriptions.join(','),
        'vin_number': vinNumbers.join(','),
        'purchase_cost': purchaseCosts.join(','),
        'company_preference': preferenceCompany.join(','),
      };

      Map<String, dynamic> response = await ApiHelper().myPostDataAuthenticated(
        'shipmentOrders',
        data,
        imageFile,
      );
      if (response['status'] == 200) {
        organoSnackBar(message: response['message']);
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      printError(info: e.toString());
      organoSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
