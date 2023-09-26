import 'dart:io';

import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/country_state_city_controller.dart';
import 'package:emjay_global/model/city_model.dart';
import 'package:emjay_global/model/country_model.dart';
import 'package:emjay_global/model/state_model.dart';
import 'package:emjay_global/view/screen/booking_tab/shipment_screens/shipment_types_consignee_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum DeliveryOption {
  Home,
  Warehouse,
}

class ShipmentTypeShipperScreen extends StatefulWidget {
  final String title;
  const ShipmentTypeShipperScreen({
    super.key,
    required this.title,
  });

  @override
  State<ShipmentTypeShipperScreen> createState() =>
      _ShipmentTypeShipperScreenState();
}

class _ShipmentTypeShipperScreenState extends State<ShipmentTypeShipperScreen> {
  TextEditingController shipperNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController picklocationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shipmentFromController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    shipperNameController.dispose();
    addressController.dispose();
    picklocationController.dispose();
    phoneController.dispose();
    shipmentFromController.dispose();
    super.dispose();
  }

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

  CountryStateCityController countryStateCityController =
      Get.put(CountryStateCityController());

  File? image;

  Future<void> _imagePicker() async {
    final imagePick = ImagePicker();
    final pickedFile = await imagePick.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);

      setState(() {
        image = file;
      });
    } else {
      return;
    }
  }

  DeliveryOption? deliveryOption;

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
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _imagePicker,
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
                      offset: const Offset(2, 2),
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Picture of Item",
                        style: TextStyle(
                          fontSize: 17,
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
              ),
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
              key: _fromKey,
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
          ],
        ),
      ),
      bottomNavigationBar: MyCustomButton(
        title: "Continue",
        onClick: () {
          if (_fromKey.currentState!.validate() &&
              deliveryOption != null &&
              image != null) {
            Get.to(
              () => ShipmentTypeConsigneeScreen(
                shipmentType: widget.title == "Personal Effect"
                    ? "1"
                    : widget.title == "Ocean Freight"
                        ? "2"
                        : widget.title == "Airplane Shipment"
                            ? "3"
                            : "4",
                title: widget.title,
                shipperName: shipperNameController.text,
                shipperAddress: addressController.text,
                phoneNo: phoneController.text,
                shipmentFrom: shipmentFromController.text,
                countryId: selectedCountryId.toString(),
                stateId: selectedStateId.toString(),
                cityId: selectedCityId.toString(),
                requestToPick: _requestToPick == false ? "no" : "yes",
                pickLocation: picklocationController.text,
                requestInsurance: _requestToInsurance == false ? "no" : "yes",
                delieryType: deliveryOption == DeliveryOption.Home
                    ? "Home"
                    : "Warehouse",
                productImage: image,
              ),
            );
            // shipperNameController.clear();
            // addressController.clear();
            // picklocationController.clear();
            // phoneController.clear();
            // shipmentFromController.clear();
          } else {
            organoSnackBar(
                message:
                    "You didn't select Image or didn't select delivery Type");
          }
        },
      ),
    );
  }
}
