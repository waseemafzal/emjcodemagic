import 'dart:convert';

import 'package:emjay_global/model/box_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BoxController extends GetxController {
  Future<List<BoxModel>> getBoxes() async {
    final response = await http
        .get(Uri.parse('https://project.cyphersol.com/emj/EmjApi/getboxes'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<BoxModel> boxes = [];
      for (var item in jsonData['data']) {
        boxes.add(BoxModel(
          id: item['id'],
          title: item['title'],
          weight: item['weight'],
          price: item['price'],
          imagePath: item['image'],
        ));
      }
      return boxes;
    } else {
      throw Exception('Failed to load boxes');
    }
  }
}
