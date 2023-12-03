import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

class MottoCard extends StatelessWidget {
  const MottoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: ksecondryLightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.admin_panel_settings_rounded,
            size: 50,
            color: ksecondryColor,
          ),
          SizedBox(width: 10),
          Text(
            "Your Privacy Is Our Priority!",
            style: TextStyle(
              fontSize: ksmallFontSize,
              color: ksecondryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}