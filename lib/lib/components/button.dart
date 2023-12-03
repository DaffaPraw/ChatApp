import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color(0xFFECB365),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                width: 2,
                color: Color(0xFF041C32),
              )),
          child: Center(
            child: Text(text,
                style: TextStyle(
                  color: Color(0xFF041C32),
                  fontWeight: FontWeight.bold,
                )),
          )),
    );
  }
}
