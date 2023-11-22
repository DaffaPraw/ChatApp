import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/setting/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InnerSettingSwitch extends StatefulWidget {
  final Setting setting;

  const InnerSettingSwitch({
    super.key,
    required this.setting,
  });

  @override
  _InnerSettingSwitchState createState() => _InnerSettingSwitchState();
}

class _InnerSettingSwitchState extends State<InnerSettingSwitch> {
  late SharedPreferences prefs;
  bool commonSwitchValue = true;

  @override
  void initState() {
    super.initState();
    loadSwitchValue();
  }

  Future<void> loadSwitchValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      commonSwitchValue = prefs.getBool('common_switch') ?? true;
    });
  }

  Future<void> saveSwitchValue(bool value) async {
    await prefs.setBool('common_switch', value);
    setState(() {
      commonSwitchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool newSwitchValue = !commonSwitchValue;
        await saveSwitchValue(newSwitchValue);
      },
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: klightContentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(widget.setting.icon, color: kprimaryColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.setting.title,
              style: const TextStyle(
                color: kprimaryColor,
                fontSize: ksmallFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Switch(
              value: commonSwitchValue,
              onChanged: (value) async {
                await saveSwitchValue(value);
                // Handle switch toggle for the specific setting if needed
                if (widget.setting.routes == '/settings/notification') {
                  // Handle switch toggle for the notification settings
                  // You can add more conditions for other settings if needed
                }
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
