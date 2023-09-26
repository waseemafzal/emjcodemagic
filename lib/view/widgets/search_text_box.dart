import 'package:flutter/material.dart';

class SearchTextBox extends StatelessWidget {
  final String myHint;
  final TextEditingController myController;
  final bool obsure;
  final TextInputType textInput;
  final Function() onClick;

  SearchTextBox({
    required this.myController,
    required this.myHint,
    this.obsure = false,
    required this.textInput,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          keyboardType: textInput,
          controller: myController,
          obscureText: obsure,
          decoration: InputDecoration(
            hintText: myHint,
            icon: GestureDetector(
              onTap: onClick,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Track Shipment",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
            fillColor: Colors.grey.shade100,
            filled: true,
          ),
        ),
      ),
    );
  }
}
