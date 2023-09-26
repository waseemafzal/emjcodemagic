import 'dart:io';

import 'package:emjay_global/controller/add_new_order_controller.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderReceiptScreen extends StatefulWidget {
  final String storeId;
  final String trackingId;
  final List<String> productList;
  final List<String> quantityList;
  final List<String> priceList;
  final String name;
  final String address;
  final String phoneNo;
  const OrderReceiptScreen({
    super.key,
    required this.storeId,
    required this.trackingId,
    required this.productList,
    required this.quantityList,
    required this.priceList,
    required this.name,
    required this.phoneNo,
    required this.address,
  });

  @override
  State<OrderReceiptScreen> createState() => _OrderReceiptScreenState();
}

class _OrderReceiptScreenState extends State<OrderReceiptScreen> {
  AddNewOrderController addNewOrderController =
      Get.put(AddNewOrderController());
  File? image;
  XFile? pickedFile;

  Future<void> _imagePicker() async {
    final imagePick = ImagePicker();
    pickedFile = await imagePick.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final file = File(pickedFile!.path);
      setState(() {
        image = file;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.storeId);
    // print(widget.trackingId);
    // print(widget.productList);
    // print(widget.priceList);
    // print(widget.quantityList);
    // print(widget.name);
    // print(widget.phoneNo);
    // print(widget.address);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a New Order",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        image as File,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      Icons.image,
                      size: 60,
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: _imagePicker,
              child: const Text(
                "Add Invoice / Receipt",
                style: TextStyle(
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () {
                return addNewOrderController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyCustomButton(
                        title: "Submit",
                        onClick: () {
                          if (image == null) {
                            Fluttertoast.showToast(
                              msg: "Please pick image",
                              backgroundColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                            );
                            return;
                          } else {
                            addNewOrderController.AddNewOrder(
                              storeId: widget.storeId,
                              trackingId: widget.trackingId,
                              productNameList: widget.productList,
                              productQuantityList: widget.quantityList,
                              productPriceList: widget.priceList,
                              username: widget.name,
                              address: widget.address,
                              phone: widget.phoneNo,
                              imageFile: image,
                            );
                          }
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
