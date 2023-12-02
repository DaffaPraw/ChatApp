import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      // style: TextStyle(color: Color(0xFFECB365)),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2)),
        // borderSide: BorderSide(color: Color(0xFF041C32), width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2)),
        // borderSide: BorderSide(color: Color(0xFFECB365), width: 2)),
        fillColor: Color.fromARGB(255, 255, 128, 0),
        // fillColor: Color(0xFF064663),
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        // hintStyle: const TextStyle(color: Color(0xFFECB365)),
      ),
    );
  }
}
