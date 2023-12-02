import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Icon? icon;

  const MyButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.icon,
  }) : super(key: key);

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
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 8), // Adjust the spacing as needed
              ],
              Text(
                text,
                style: TextStyle(
                  color: Color(0xFF041C32),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
