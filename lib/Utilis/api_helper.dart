import 'dart:convert';
import 'dart:io';

import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import 'mighty_exception.dart';

class ApiHelper {
  AuthController authController = Get.find();
  postData(String url, [Map<String, dynamic> data = const {}]) async {
    try {
      final String finalUrl = kcBaseAPIUrl + url;
      print("Api call --> ${finalUrl}");

      var res = await http.post(Uri.parse(finalUrl),
          body: data, headers: {'accept': 'application/json'});
      print("API :: ${finalUrl} :: Data :: ${data} :: Response :: ${res.body}");
      var body = jsonDecode(res.body);

      if (body['status'] != 200) throw MyExceptions(body['message']);

      return body;
    } on FormatException catch (e) {
      Get.snackbar("Error", "$e");
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: "API HELPER ${e.toString()}");
      rethrow;
    }
  }

  getData(String url, [Map<String, dynamic> data = const {}]) async {
    try {
      final String finalUrl = kcBaseAPIUrl + url;

      var res = await http.get(
        Uri.parse(finalUrl),
        headers: {
          'accept': 'application/json',
          'accesstoken': authController.accesstoken,
        },
      );

      print("API :: ${finalUrl} :: Data :: ${data} :: Response :: ${res.body}");
      var body = jsonDecode(res.body);

      if (body['status'] != 200) throw MyExceptions(body['message']);

      return body;
    } on FormatException catch (e) {
      Get.snackbar("Error", "$e");
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: "API HELPER");
      rethrow;
    }
  }

  postDataAuthenticated(String url,
      [Map<String, dynamic> data = const {}]) async {
    try {
      final String finalUrl = kcBaseAPIUrl + url;

      AuthController authController = Get.find();

      var res = await http.post(
        Uri.parse(finalUrl),
        body: data,
        headers: {
          'accept': 'application/json',
          'accesstoken': authController.accesstoken
        },
      );
      print("API :: ${finalUrl} :: Data :: ${data} :: Response :: ${res.body}");
      var body = jsonDecode(res.body);

      print("STATU CODE :: ${body['status']}");
      if (body['status'] != 200 && body['status'] != null)
        throw MyExceptions(body['message'] ?? 'An error occurred.');

      return body;
    } on FormatException catch (e) {
      organoSnackBar(message: "$e");
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: "API HELPER");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> myPostDataAuthenticated(String url,
      [Map<String, String> data = const {}, File? imageFile]) async {
    try {
      final String finalUrl = kcBaseAPIUrl + url;

      AuthController authController = Get.find<AuthController>();

      var request = http.MultipartRequest('POST', Uri.parse(finalUrl));

      request.headers.addAll({
        'accept': 'application/json',
        'accesstoken': authController.accesstoken,
      });

      request.fields.addAll(data);

      if (imageFile != null) {
        var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile(
          'file',
          stream,
          length,
          filename: imageFile.path.split(',').last,
        );

        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print(
          "API :: ${finalUrl} :: Data :: ${request.fields} :: Response :: $responseBody");
      var body = jsonDecode(responseBody);

      print("STATUS CODE :: ${body['status']}");
      if (body['status'] != 200 && body['status'] != null)
        throw MyExceptions(body['message'] ?? 'An error occurred.');

      return body;
    } on FormatException catch (e) {
      Get.snackbar("Error", "$e");
      throw MyExceptions('An error occurred: $e');
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: "API HELPER");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> myOrderPostDataAuthenticated(String url,
      [Map<String, String> data = const {}, File? imageFile]) async {
    try {
      final String finalUrl = kcBaseAPIUrl + url;

      AuthController authController = Get.find<AuthController>();

      var request = http.MultipartRequest('POST', Uri.parse(finalUrl));

      request.headers.addAll({
        'accept': 'application/json',
        'accesstoken': authController.accesstoken,
      });

      request.fields.addAll(data);

      if (imageFile != null) {
        var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: imageFile.path.split(',').last,
        );

        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print(
          "API :: ${finalUrl} :: Data :: ${request.fields} :: Response :: $responseBody");
      var body = jsonDecode(responseBody);

      print("STATUS CODE :: ${body['status']}");
      if (body['status'] != 200 && body['status'] != null)
        throw MyExceptions(body['message'] ?? 'An error occurred.');

      return body;
    } on FormatException catch (e) {
      Get.snackbar("Error", "$e");
      throw MyExceptions('An error occurred: $e');
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: "API HELPER");
      rethrow;
    }
  }
}
