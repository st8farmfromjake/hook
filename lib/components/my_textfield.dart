import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool isError;


  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.isError = false 
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: isError? Colors.red : Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: isError ? const Color.fromARGB(255, 255, 194, 194) : Colors.grey.shade200, // Use isError to determine fillColor
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: isError? Colors.grey[600] : Colors.grey[500])

        ),
      ),
    );
  }
}
