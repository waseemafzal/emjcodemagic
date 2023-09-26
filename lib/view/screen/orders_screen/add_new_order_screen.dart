import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/shop_controller.dart';
import 'package:emjay_global/model/shop_model.dart';
import 'package:emjay_global/view/screen/orders_screen/order_address_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewOrderScreen extends StatefulWidget {
  const AddNewOrderScreen({Key? key}) : super(key: key);

  @override
  _AddNewOrderScreenState createState() => _AddNewOrderScreenState();
}

class _AddNewOrderScreenState extends State<AddNewOrderScreen> {
  TextEditingController storeController = TextEditingController();
  TextEditingController trackingNoController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController perUnitPriceController = TextEditingController();

  ShopController shopController = Get.put(ShopController());

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  List<ShopModel> shopList = [];
  String? selectedShopId;

  Future<void> _loadStores() async {
    try {
      shopList = await shopController.getStores();
      if (shopList.isNotEmpty) {
        setState(() {
          selectedShopId = shopList.first.shopId;
        });
      }
    } catch (e) {
      // Handle the error
      print('$e');
    }
  }

  final List<String> myProductName = [];
  final List<String> myProductQuantity = [];
  final List<String> myProductPrice = [];
  List<Map<String, dynamic>> combinedList = [];

  void addProduct() {
    if (productNameController.text.isNotEmpty &&
        perUnitPriceController.text.isNotEmpty &&
        quantityController.text.isNotEmpty) {
      combinedList.clear();
      myProductName.add(productNameController.text);
      myProductQuantity.add(quantityController.text);
      myProductPrice.add(perUnitPriceController.text);
      for (int i = 0; i < myProductName.length; i++) {
        combinedList.add({
          "name": myProductName[i],
          "quantity": myProductQuantity[i],
          "price": myProductPrice[i],
        });
      }
      printApiResponse("$myProductName");
      printApiResponse("$myProductQuantity");
      printApiResponse("$myProductPrice");
      printApiResponse("$combinedList");

      productNameController.clear();
      quantityController.clear();
      perUnitPriceController.clear();
      Get.back();
    } else {
      organoSnackBar(message: "Some Fields are Empty");
    }
  }

  productBottomSheet() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyCustomTextBox(
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product Name';
                } else if (value.contains(',')) {
                  return 'Please remove ,';
                }
                return null;
              },
              myController: productNameController,
              myHint: 'Product Name',
            ),
            MyCustomTextBox(
              keyboardType: TextInputType.number,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Quantity';
                } else if (value.contains(',')) {
                  return 'Please remove ,';
                }
                return null;
              },
              myController: quantityController,
              myHint: 'Product Quantity',
            ),
            MyCustomTextBox(
              keyboardType: TextInputType.number,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product Price';
                } else if (value.contains(',')) {
                  return 'Please remove ,';
                }
                return null;
              },
              myController: perUnitPriceController,
              myHint: 'Product Price',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    addProduct();

                    setState(() {
                      combinedList;
                    });
                  },
                  child: Text('ADD'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a New Order',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text('Online Store'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: DropdownButtonFormField<String>(
                value: selectedShopId,
                onChanged: (newValue) {
                  setState(() {
                    selectedShopId = newValue;
                  });
                },
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                items: shopList.map((shop) {
                  return DropdownMenuItem<String>(
                    value: shop.shopId,
                    child: Text(shop.shopName),
                  );
                }).toList(),
                hint: const Text('Select Your Favorite Store'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text('Add a Tracking Number'),
            ),
            MyCustomTextBox(
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Tracking Number';
                }
                return null;
              },
              myController: trackingNoController,
              myHint: 'Enter Tracking Number',
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: const Center(
                child: Text(
                  'ITEM DETAILS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: productBottomSheet(),
                          );
                        });
                  },
                  icon: Icon(Icons.add),
                  label: Text('ADD ITEMS'),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            combinedList.isEmpty
                ? const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Center(
                      child: Text(
                        'No items added',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: combinedList.length,
                      itemBuilder: (context, index) {
                        final product = combinedList[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.white,
                                child: FittedBox(
                                  child: Text(
                                    '${product['quantity']}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(product['name']),
                            subtitle: Text("Price : ${product['price']}"),
                            trailing: IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "Delete",
                                    content: Text("Do you want to Delete?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          combinedList.removeAt(index);
                                          myProductName.removeAt(index);
                                          myProductPrice.removeAt(index);
                                          myProductQuantity.removeAt(index);
                                          setState(() {
                                            myProductName;
                                            myProductPrice;
                                            myProductQuantity;
                                            combinedList;
                                          });
                                          Get.back();
                                        },
                                        child: Text("Yes"),
                                      ),
                                    ]);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyCustomButton(
        title: 'DONE',
        onClick: () {
          if (myProductName.isNotEmpty) {
            if (trackingNoController.text.isNotEmpty) {
              Get.to(
                () => OrderAddressScreen(
                  storeId: selectedShopId.toString(),
                  trackingId: trackingNoController.text.trim(),
                  productList: myProductName,
                  quantityList: myProductQuantity,
                  priceList: myProductPrice,
                ),
              );
            } else {
              organoSnackBar(message: "Please enter Tracking Number");
            }
          } else {
            organoSnackBar(message: "'Please add items'");
          }
        },
      ),
    );
  }
}
