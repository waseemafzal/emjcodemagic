import 'dart:io';

import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/auth_controller.dart';
import 'package:emjay_global/controller/profile_controller.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:emjay_global/view/widgets/password_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = profileController.email.toString();
    mobileController.text = profileController.phone.toString();
    addressController.text = profileController.address.toString();
    lastnameController.text = profileController.lastname.toString();
    firstnameController.text = profileController.firstname.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          GestureDetector(
            onTap: _imagePicker,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              height: 100,
              width: 100,
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        image as File,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: Column(children: [
              MyCustomTextBox(
                myController: firstnameController,
                myHint: "First Name",
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter First Name";
                  } else {
                    return null;
                  }
                },
              ),
              MyCustomTextBox(
                myController: lastnameController,
                myHint: "Last Name",
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Last Name";
                  } else {
                    return null;
                  }
                },
              ),
              MyCustomTextBox(
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Email";
                  } else {
                    return null;
                  }
                },
                myController: emailController,
                myHint: "Email",
              ),
              MyCustomTextBox(
                keyboardType: TextInputType.phone,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Mobile No.";
                  } else {
                    return null;
                  }
                },
                myController: mobileController,
                myHint: "Mobile No",
              ),
              MyCustomTextBox(
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Address";
                  } else {
                    return null;
                  }
                },
                myController: addressController,
                myHint: "Address",
              ),
            ]),
          ),
          PasswordTextBox(
            validate: (value) {
              if (value!.isEmpty) {
                return "Please enter Password";
              } else {
                return null;
              }
            },
            myController: passwordController,
            myHint: "Password",
            mySuffixIcon:
                _showPassword == true ? Icons.visibility_off : Icons.visibility,
            obsure: _showPassword,
            onClick: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
          PasswordTextBox(
            validate: (value) {
              if (value!.isEmpty) {
                return "Confirm Your Password";
              } else {
                return null;
              }
            },
            myController: confPasswordController,
            myHint: "Confirm Password",
            mySuffixIcon:
                _showPassword == true ? Icons.visibility_off : Icons.visibility,
            obsure: _showPassword,
            onClick: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
        ],
      )),
      bottomNavigationBar: Obx(
        () {
          return authController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : MyCustomButton(
                  title: "Update",
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      if (image != null) {
                        if (passwordController.text.trim() ==
                            confPasswordController.text.trim()) {
                          authController.updateProfile(
                            firstname: firstnameController.text.trim(),
                            lastname: lastnameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: mobileController.text.trim(),
                            address: addressController.text.trim(),
                            password: passwordController.text.trim(),
                            imageFile: image,
                          );
                        } else {
                          organoSnackBar(message: "Password didn't match");
                        }
                      } else {
                        organoSnackBar(message: "Please select image");
                      }
                    } else {
                      organoSnackBar(message: "Some Fields are empty");
                    }
                  },
                );
        },
      ),
    );
  }
}
