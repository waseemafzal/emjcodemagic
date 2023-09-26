import 'package:flutter/material.dart';

class MyCustomTextBox extends StatefulWidget {
  final String myHint;
  final TextEditingController myController;
  final bool obsure;
  final int maxLine;
  final TextInputType keyboardType;
  final Function(String?)? validate;
  final bool readOnly;

  MyCustomTextBox({
    required this.myController,
    required this.myHint,
    this.maxLine = 1,
    this.obsure = false,
    this.keyboardType = TextInputType.text,
    this.validate,
    this.readOnly = false,
  });

  @override
  State<MyCustomTextBox> createState() => _MyCustomTextBoxState();
}

class _MyCustomTextBoxState extends State<MyCustomTextBox> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: TextFormField(
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLine,
        controller: widget.myController,
        obscureText: widget.obsure,
        validator: (value) {
          return _errorText ?? widget.validate?.call(value) ?? null;
        },
        decoration: InputDecoration(
          hintText: widget.myHint,
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
    );
  }
}
