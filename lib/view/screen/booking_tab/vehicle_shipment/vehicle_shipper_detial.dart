import 'dart:io';

import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/country_state_city_controller.dart';
import 'package:emjay_global/model/city_model.dart';
import 'package:emjay_global/model/country_model.dart';
import 'package:emjay_global/model/state_model.dart';
import 'package:emjay_global/view/screen/booking_tab/vehicle_shipment/vehicle_consignee_detial.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum DeliveryOption {
  Home,
  Warehouse,
}

class VehicleShipperDetail extends StatefulWidget {
  final String title;
  const VehicleShipperDetail({
    super.key,
    required this.title,
  });

  @override
  State<VehicleShipperDetail> createState() => _VehicleShipperDetailState();
}

class _VehicleShipperDetailState extends State<VehicleShipperDetail> {
  TextEditingController shipperNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController picklocationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shipmentFromController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  CountryStateCityController countryStateCityController =
      Get.put(CountryStateCityController());

  File? image;
  XFile? pickedFile;

  bool _requestToPick = false;
  bool _requestToInsurance = false;

  String? selectedCountryId;
  String? selectedStateId;
  String? selectedCityId;

  List<CountryModel> countries = [];
  List<StateModel> states = [];
  List<CityModel> cities = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      countries = await countryStateCityController.getCountries();
      if (countries.isNotEmpty) {
        setState(() {
          selectedCountryId = countries.first.countryId;
        });
        _loadStates();
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    }
  }

  Future<void> _loadStates() async {
    try {
      states = await countryStateCityController
          .getStatesByCountryId(selectedCountryId!);
      if (states.isNotEmpty) {
        setState(() {
          selectedStateId = states.first.stateId;
        });
        _loadCities();
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    }
  }

  Future<void> _loadCities() async {
    try {
      cities =
          await countryStateCityController.getCitiesByStateId(selectedStateId!);
      if (cities.isNotEmpty) {
        setState(() {
          selectedCityId = cities.first.cityId;
        });
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    }
  }

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

  DeliveryOption? deliveryOption;

  Widget _pictureTile({
    required String title,
    required Function() onClick,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(2, 2),
              color: Colors.grey.shade300,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image as File,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.image,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
          ],
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController vehiclePurchaseController = TextEditingController();
  TextEditingController preferenceComapnyController = TextEditingController();
  final List<String> myDescriptionList = [];
  final List<String> myVinnumberList = [];
  final List<String> myPurchaseCostList = [];
  final List<String> myPreferenceCompanyList = [];

  List<Map<String, dynamic>> combinedList = [];

  void addVehicle() {
    if (descriptionController.text.isNotEmpty &&
        vinController.text.isNotEmpty &&
        vehiclePurchaseController.text.isNotEmpty &&
        preferenceComapnyController.text.isNotEmpty) {
      combinedList.clear();
      myDescriptionList.add(descriptionController.text);
      myPurchaseCostList.add(vehiclePurchaseController.text);
      myVinnumberList.add(vinController.text);
      myPreferenceCompanyList.add(preferenceComapnyController.text);
      for (int i = 0; i < myDescriptionList.length; i++) {
        combinedList.add({
          "name": myDescriptionList[i],
          "price": myPurchaseCostList[i],
          "vin": myVinnumberList[i],
          'company': myPreferenceCompanyList[i],
        });
      }
      printApiResponse("$myDescriptionList");
      printApiResponse("$myPurchaseCostList");
      printApiResponse("$myVinnumberList");
      printApiResponse("$myPreferenceCompanyList");
      printApiResponse("$combinedList");

      descriptionController.clear();
      vehiclePurchaseController.clear();
      vinController.clear();
      preferenceComapnyController.clear();
      Get.back();
    } else {
      organoSnackBar(message: "Some Fields are Empty");
    }
  }

  vehicleBottomSheet() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyCustomTextBox(
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter Product Description";
                } else if (value.contains(",")) {
                  return "Please remove ,";
                } else {
                  return null;
                }
              },
              myController: descriptionController,
              myHint: "Vehicle Description",
            ),
            MyCustomTextBox(
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter vin number";
                  } else if (value.contains(",")) {
                    return "Please remove ,";
                  } else {
                    return null;
                  }
                },
                myController: vinController,
                myHint: "Vin number"),
            MyCustomTextBox(
              keyboardType: TextInputType.number,
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter vehicle Purchase Cost";
                } else if (value.contains(",")) {
                  return "Please remove ,";
                } else {
                  return null;
                }
              },
              myController: vehiclePurchaseController,
              myHint: "Vehicle Purchase Cost",
            ),
            MyCustomTextBox(
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Shipping Company Preference";
                  } else {
                    return null;
                  }
                },
                myController: preferenceComapnyController,
                myHint: "Shipping Company Preference"),
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
                    addVehicle();
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
          "Book",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
              child: const Text(
                "Vehicle Shipment",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: _pictureTile(title: "Invoice", onClick: _imagePicker),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5,
              ),
              child: Text(
                "Shipper's Details",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Shipper name";
                          } else {
                            return null;
                          }
                        },
                        myController: shipperNameController,
                        myHint: "Shipper Name"),
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Shipper Address";
                          } else {
                            return null;
                          }
                        },
                        myController: addressController,
                        myHint: "Address"),
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Mobile No.";
                        } else {
                          return null;
                        }
                      },
                      myController: phoneController,
                      myHint: "Mobile No",
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter value of Shipment From";
                        } else {
                          return null;
                        }
                      },
                      myController: shipmentFromController,
                      myHint: "Shipment From",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<String>(
                          value: selectedCountryId,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCountryId = newValue;
                              selectedStateId = null;
                              selectedCityId = null;
                              _loadStates();
                            });
                          },
                          icon: Expanded(
                            child: Icon(
                              Icons.arrow_drop_down_circle,
                              color: Theme.of(context).primaryColor,
                            ),
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
                          items: countries.map((country) {
                            return DropdownMenuItem<String>(
                              value: country.countryId,
                              child: Text(country.countryName),
                            );
                          }).toList(),
                          hint: const Text('Select Country'),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedStateId,
                          onChanged: (newValue) {
                            setState(() {
                              selectedStateId = newValue;
                              selectedCityId = null;
                              _loadCities();
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
                          items: states.map((state) {
                            return DropdownMenuItem<String>(
                              value: state.stateId,
                              child: Text(state.stateName),
                            );
                          }).toList(),
                          hint: const Text('Select State'),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedCityId,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCityId = newValue;
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
                          items: cities.map((city) {
                            return DropdownMenuItem<String>(
                              value: city.cityId,
                              child: Text(city.cityName),
                            );
                          }).toList(),
                          hint: const Text('Select City'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      tileColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      title: const Text(
                        "Request Pick Up",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      value: _requestToPick,
                      onChanged: (value) {
                        setState(
                          () {
                            _requestToPick = value!;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Pick Location";
                          } else {
                            return null;
                          }
                        },
                        myController: picklocationController,
                        myHint: "Pick location"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      tileColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      title: const Text(
                        "Request Insurance",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      value: _requestToInsurance,
                      onChanged: (value) {
                        setState(
                          () {
                            _requestToInsurance = value!;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<DeliveryOption>(
                            dense: true,
                            title: Text(
                              DeliveryOption.Home.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            tileColor: Colors.white,
                            contentPadding: const EdgeInsets.all(0.0),
                            value: DeliveryOption.Home,
                            groupValue: deliveryOption,
                            onChanged: (value) {
                              setState(() {
                                deliveryOption = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RadioListTile<DeliveryOption>(
                            dense: true,
                            title: Text(
                              DeliveryOption.Warehouse.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            tileColor: Colors.white,
                            contentPadding: const EdgeInsets.all(0.0),
                            value: DeliveryOption.Warehouse,
                            groupValue: deliveryOption,
                            onChanged: (value) {
                              setState(() {
                                deliveryOption = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Text(
                "Vehicle Detail",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Container(
              width: double.infinity,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return vehicleBottomSheet();
                        });
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Vehicle"),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            combinedList.length == 0
                ? const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Center(
                      child: Text(
                        "No Vehicle added",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    height: 200,
                    child: ListView.builder(
                        itemCount: combinedList.length,
                        itemBuilder: (context, index) {
                          final vehicle = combinedList[index];
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 13,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text("NAME : ${vehicle['name']}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(" VIN # : ${vehicle['vin']}"),
                                  Text(" PRICE  : ${vehicle['price']} \$"),
                                  Text(" COMPANY : ${vehicle['company']}"),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      content:
                                          const Text("Are you sure to delete?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("No"),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("Yes"),
                                          onPressed: () {
                                            combinedList.removeAt(index);
                                            myDescriptionList.removeAt(index);
                                            myPurchaseCostList.removeAt(index);
                                            myVinnumberList.removeAt(index);
                                            myPreferenceCompanyList
                                                .removeAt(index);
                                            setState(() {
                                              myDescriptionList;
                                              myVinnumberList;
                                              myPurchaseCostList;
                                              myPreferenceCompanyList;
                                              combinedList;
                                            });
                                            Get.back();
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          );
                        }),
                  ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyCustomButton(
        title: "Continue",
        onClick: () {
          if (_formKey.currentState!.validate()) {
            if (myDescriptionList.isNotEmpty) {
              if (image != null) {
                Get.to(
                  () => VehicleConsigneeDetail(
                    title: widget.title,
                    shipmentType: "4",
                    shipperName: shipperNameController.text,
                    shipperAddress: addressController.text,
                    phoneNo: phoneController.text,
                    shipmentFrom: shipmentFromController.text,
                    countryId: selectedCountryId.toString(),
                    stateId: selectedStateId.toString(),
                    cityId: selectedCityId.toString(),
                    requestToPick: _requestToPick == false ? "no" : "yes",
                    pickLocation: picklocationController.text,
                    requestInsurance:
                        _requestToInsurance == false ? "no" : "yes",
                    delieryType: deliveryOption == DeliveryOption.Home
                        ? "Home"
                        : "Warehouse",
                    productImage: image,
                    myDescriptionList: myDescriptionList,
                    myVinnumberList: myVinnumberList,
                    myPurchaseCostList: myPurchaseCostList,
                    myPreferenceCompanyList: myPreferenceCompanyList,
                  ),
                );
              } else {
                organoSnackBar(message: "Please add image");
              }
            } else {
              organoSnackBar(message: "Your are not added Vehicle Details");
            }
          } else {
            organoSnackBar(message: "Some Fields are empty");
          }
        },
      ),
    );
  }
}
