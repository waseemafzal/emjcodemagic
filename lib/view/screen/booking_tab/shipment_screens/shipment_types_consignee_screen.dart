import 'dart:io';

import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/country_state_city_controller.dart';
import 'package:emjay_global/model/city_model.dart';
import 'package:emjay_global/model/country_model.dart';
import 'package:emjay_global/model/state_model.dart';
import 'package:emjay_global/view/screen/booking_tab/package_size_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShipmentTypeConsigneeScreen extends StatefulWidget {
  final String shipmentType;
  final String title;
  final String shipperName;
  final String shipperAddress;
  final String phoneNo;
  final String shipmentFrom;
  final String countryId;
  final String stateId;
  final String cityId;
  final String requestToPick;
  final String pickLocation;
  final String requestInsurance;
  final String delieryType;
  final File? productImage;

  ShipmentTypeConsigneeScreen({
    required this.title,
    required this.shipmentType,
    required this.shipperName,
    required this.shipperAddress,
    required this.phoneNo,
    required this.shipmentFrom,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.requestToPick,
    required this.pickLocation,
    required this.requestInsurance,
    required this.delieryType,
    required this.productImage,
  });

  @override
  State<ShipmentTypeConsigneeScreen> createState() =>
      _ShipmentTypeConsigneeScreenState();
}

class _ShipmentTypeConsigneeScreenState
    extends State<ShipmentTypeConsigneeScreen> {
  TextEditingController consigneeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController picklocationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shipmentToController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  CountryStateCityController countryStateCityController =
      Get.put(CountryStateCityController());
  String? _errorText;

  Widget _demensionBuilder({
    required String title,
    required TextEditingController myController,
    required Function(String?)? validate,
  }) {
    return Expanded(
      child: SizedBox(
        height: 60,
        width: 40,
        child: TextFormField(
          validator: (value) {
            return _errorText ?? validate?.call(value);
          },
          keyboardType: TextInputType.number,
          controller: myController,
          decoration: InputDecoration(
            hintText: title,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    consigneeController.dispose();
    addressController.dispose();
    picklocationController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    heightController.dispose();
    widthController.dispose();
    lengthController.dispose();
    phoneController.dispose();
    shipmentToController.dispose();
    super.dispose();
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
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5,
              ),
              child: Text(
                "Consignee's Details",
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
                          return "Please enter Consignee Name";
                        } else {
                          return null;
                        }
                      },
                      myController: consigneeController,
                      myHint: "Consignee Name",
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Consignee Address";
                        } else {
                          return null;
                        }
                      },
                      myController: addressController,
                      myHint: "Consignee Address",
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Consignee Mobile No";
                        } else {
                          return null;
                        }
                      },
                      myController: phoneController,
                      keyboardType: TextInputType.phone,
                      myHint: "Consignee Phone",
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Shipment To";
                        } else {
                          return null;
                        }
                      },
                      myController: shipmentToController,
                      myHint: "Shipment To",
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
                  MyCustomTextBox(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Item Description";
                      } else {
                        return null;
                      }
                    },
                    myController: descriptionController,
                    myHint: "Item Description",
                    maxLine: 2,
                  ),
                  SizedBox(
                    height: 65,
                    child: MyCustomTextBox(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Quantity";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      myController: quantityController,
                      myHint: "Quantity",
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Diemensions",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Form(
                      child: Row(
                        children: [
                          _demensionBuilder(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter Length";
                                } else {
                                  return null;
                                }
                              },
                              title: "Length",
                              myController: lengthController),
                          const SizedBox(width: 5),
                          _demensionBuilder(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter width";
                                } else {
                                  return null;
                                }
                              },
                              title: "Width",
                              myController: widthController),
                          const SizedBox(width: 5),
                          _demensionBuilder(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter height";
                                } else {
                                  return null;
                                }
                              },
                              title: "Height",
                              myController: heightController),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              height: 60,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "CM",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Text(
                  "Emjay collect some's of your personal data strictly providing you with an optimizing user experience and to enable us to carry out the services you request from emjay."),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyCustomButton(
        title: "Submit",
        onClick: () {
          if (_formKey.currentState!.validate() &&
              lengthController.text.isNotEmpty &&
              widthController.text.isNotEmpty &&
              heightController.text.isNotEmpty) {
            Get.to(
              () => PackageSizeScreen(
                shipmentType: widget.shipmentType,
                shipperName: widget.shipperName,
                shipperAddress: widget.shipperAddress,
                shipperphoneNo: widget.phoneNo,
                shipmentFrom: widget.shipmentFrom,
                shippercountryId: widget.countryId,
                shipperstateId: widget.stateId,
                shippercityId: widget.cityId,
                shipperrequestToPick: widget.requestToPick,
                shipperrequestInsurance: widget.requestInsurance,
                shipperpickLocation: widget.pickLocation,
                shipperdelieryType: widget.delieryType,
                productImage: widget.productImage,
                consigneeName: consigneeController.text,
                consigneeAddress: addressController.text,
                consigneePhone: phoneController.text,
                shipmentTo: shipmentToController.text,
                consigneeCountryId: selectedCountryId!,
                consigneeStateId: selectedStateId!,
                consigneeCityId: selectedCityId!,
                quantity: quantityController.text,
                description: descriptionController.text,
                length: lengthController.text,
                height: heightController.text,
                width: widthController.text,
              ),
            );
            // consigneeController.clear();
            // addressController.clear();
            // picklocationController.clear();
            // descriptionController.clear();
            // quantityController.clear();
            // heightController.clear();
            // widthController.clear();
            // lengthController.clear();
            // phoneController.clear();
            // shipmentToController.clear();
          } else {
            organoSnackBar(message: "Some Fields are Empty");
          }
        },
      ),
    );
  }
}
