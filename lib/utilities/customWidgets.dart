import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    required this.controller,
    required this.labelText,
    this.obsecureText,
    this.validator,
  });
  TextEditingController? controller;
  String? labelText;
  bool? obsecureText;
  String Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obsecureText!,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
