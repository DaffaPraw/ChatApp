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
  late String switchKey; 
  bool switchValue = true;

  @override
  void initState() {
    super.initState();
    switchKey = 'switch_${widget.setting.title.toLowerCase()}';
    loadSwitchValue();
  }

  Future<void> loadSwitchValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      switchValue = prefs.getBool(switchKey) ?? true;
    });
  }

  Future<void> saveSwitchValue(bool value) async {
    await prefs.setBool(switchKey, value);
    setState(() {
      switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool newSwitchValue = !switchValue;
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
              value: switchValue,
              onChanged: (value) async {
                await saveSwitchValue(value);
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
