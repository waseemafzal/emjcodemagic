import 'package:flutter/material.dart';

class PasswordTextBox extends StatefulWidget {
  final String myHint;
  final TextEditingController myController;
  final bool obsure;
  final IconData mySuffixIcon;
  final Function() onClick;

  final Function(String?)? validate;
  PasswordTextBox({
    required this.myController,
    required this.myHint,
    this.obsure = true,
    required this.onClick,
    required this.mySuffixIcon,
    this.validate,
  });

  @override
  State<PasswordTextBox> createState() => _PasswordTextBoxState();
}

class _PasswordTextBoxState extends State<PasswordTextBox> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: TextFormField(
        validator: (value) {
          return _errorText ?? widget.validate?.call(value) ?? null;
        },
        controller: widget.myController,
        obscureText: widget.obsure,
        decoration: InputDecoration(
          hintText: widget.myHint,
          suffixIcon: GestureDetector(
            onTap: widget.onClick,
            child: Icon(widget.mySuffixIcon),
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
    );
  }
}
