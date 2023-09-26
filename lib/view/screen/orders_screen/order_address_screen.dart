import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/profile_controller.dart';
import 'package:emjay_global/view/screen/orders_screen/order_receipt_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class OrderAddressScreen extends StatefulWidget {
  final String storeId;
  final String trackingId;
  final List<String> productList;
  final List<String> quantityList;
  final List<String> priceList;
  const OrderAddressScreen({
    super.key,
    required this.storeId,
    required this.trackingId,
    required this.productList,
    required this.quantityList,
    required this.priceList,
  });

  @override
  State<OrderAddressScreen> createState() => _OrderAddressScreenState();
}

class _OrderAddressScreenState extends State<OrderAddressScreen> {
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showAddressForm = false;
  bool readOnly = true;

  LatLng? selectedLocation;
  LatLng showLocation = LatLng(27.7089427, 85.3086209);
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    nameController.text =
        "${profileController.firstname} ${profileController.lastname}";
    addressController.text = "${profileController.address}";
    phoneController.text = "${profileController.phone}";
  }

  var location = loc.Location();
  loc.LocationData? currentLocation; // Store the current location data

  Future<void> getCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();

      // Add a marker for the current location
      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId("current_location"),
            position:
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue), // Customize the marker icon
            infoWindow: InfoWindow(
              title: "Current Location",
              snippet:
                  "Lat: ${currentLocation!.latitude}, Lng: ${currentLocation!.longitude}",
            ),
          ),
        );
      });

      // Move the camera to the current location
      mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        ),
      );
    } catch (e) {
      print("Error obtaining location: $e");
    }
  }

  void moveMapUp() {
    final CameraUpdate cameraUpdate = CameraUpdate.scrollBy(
        0.0, -100.0); // Adjust the vertical scroll distance as needed
    mapController?.animateCamera(cameraUpdate);
  }

  void moveMapDown() {
    final CameraUpdate cameraUpdate = CameraUpdate.scrollBy(
        0.0, 100.0); // Adjust the vertical scroll distance as needed
    mapController?.animateCamera(cameraUpdate);
  }

  void moveMapLeft() {
    final CameraUpdate cameraUpdate = CameraUpdate.scrollBy(
        -100.0, 0.0); // Adjust the horizontal scroll distance as needed
    mapController?.animateCamera(cameraUpdate);
  }

  void moveMapRight() {
    final CameraUpdate cameraUpdate = CameraUpdate.scrollBy(
        100.0, 0.0); // Adjust the horizontal scroll distance as needed
    mapController?.animateCamera(cameraUpdate);
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Address",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            readOnly = false;
                            _showAddressForm = !_showAddressForm;
                          });
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            phoneController.clear();
                            addressController.clear();
                            nameController.clear();
                            _showAddressForm = !_showAddressForm;
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )
                ],
              ),
              _showAddressForm
                  ? Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          MyCustomTextBox(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter name";
                              } else {
                                return null;
                              }
                            },
                            readOnly: readOnly,
                            myController: nameController,
                            myHint: "Enter Name",
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Text(
                              "Address",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          MyCustomTextBox(
                            readOnly: readOnly,
                            myController: addressController,
                            myHint: "Enter Address",
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          MyCustomTextBox(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter phone";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            readOnly: readOnly,
                            myController: phoneController,
                            myHint: "Enter Phone Number",
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            color: Colors.grey.shade300,
                            height: 150,
                            child: GoogleMap(
                              zoomGesturesEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: showLocation,
                                zoom: 2.0,
                              ),
                              markers: markers,
                              mapType: MapType.normal,
                              onMapCreated: (controller) {
                                setState(() {
                                  mapController = controller;
                                });
                                getCurrentLocation();
                              },
                              onTap: (LatLng location) async {
                                setState(() {
                                  selectedLocation = location;
                                  markers.clear();
                                });

                                // Reverse geocode the selected location to obtain an address
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                  location.latitude,
                                  location.longitude,
                                );

                                if (placemarks.isNotEmpty) {
                                  // Extract country name and place name from the placemark
                                  String countryName =
                                      placemarks[0].country ?? 'Country';
                                  String placeName =
                                      placemarks[0].name ?? 'Place Name';

                                  // Add a marker at the selected location with custom title and snippet
                                  setState(() {
                                    markers.add(
                                      Marker(
                                        markerId: MarkerId(location.toString()),
                                        position: location,
                                        infoWindow: InfoWindow(
                                          title: countryName,
                                          snippet: placeName,
                                        ),
                                        icon: BitmapDescriptor.defaultMarker,
                                      ),
                                    );

                                    // Update the addressController with the first result's address
                                    addressController.text = placeName;
                                  });
                                }
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              printApiResponse("${selectedLocation?.latitude}");
                              if (selectedLocation != null) {
                                // Update the addressController with the selected location's coordinates
                                addressController.text =
                                    "Lat: ${selectedLocation?.latitude}, Lng: ${selectedLocation?.longitude}";

                                // Use geocoding to fetch the address
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                  selectedLocation!.latitude,
                                  selectedLocation!.longitude,
                                );

                                if (placemarks.isNotEmpty) {
                                  String address =
                                      placemarks[0].street.toString();
                                  // You can customize this to include more details if needed
                                  printApiResponse(address);
                                  setState(() {
                                    addressController.text = address;
                                  });
                                }
                              }
                            },
                            child: Text("Pick Selected Location"),
                          )
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 5,
              ),
              _showAddressForm
                  ? MyCustomButton(
                      title: "Next Step",
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          Get.to(
                            () => OrderReceiptScreen(
                              storeId: widget.storeId,
                              trackingId: widget.trackingId,
                              productList: widget.productList,
                              quantityList: widget.quantityList,
                              priceList: widget.priceList,
                              name: nameController.text.trim(),
                              phoneNo: phoneController.text.trim(),
                              address: addressController.text.trim(),
                            ),
                          );
                        } else {
                          organoSnackBar(message: "Some Fields are Empty");
                        }
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
