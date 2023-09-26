import 'dart:convert';

import 'package:emjay_global/model/shop_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ShopController extends GetxController {
  RxBool isLoading = false.obs;
  Future<List<ShopModel>> getStores() async {
    final response = await http
        .get(Uri.parse('https://project.cyphersol.com/emj/emjApi/getStores'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData['data']);
      List<ShopModel> shopList = [];
      for (var item in jsonData['data']) {
        shopList.add(ShopModel(
          shopId: item['id'],
          shopName: item['store_name'],
        ));
      }
      return shopList;
    } else {
      throw Exception('Failed to load states');
    }
  }
}
