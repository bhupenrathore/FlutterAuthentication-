import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller1;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller1,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller1,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade700)),
            fillColor: Colors.grey[200],
            filled: true),
      ),
    );
  }
}
