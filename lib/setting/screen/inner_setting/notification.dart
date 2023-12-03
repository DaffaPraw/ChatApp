import 'package:chat_app/setting/widgets/inner_setting/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/setting/models/setting.dart';
import 'package:chat_app/setting/widgets/avatar_card.dart';
import 'package:chat_app/setting/widgets/setting_tile.dart';
import 'package:chat_app/setting/widgets/motto_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
              children: [
                Column(
                  children: List.generate(
                    settings.length,
                    (index) => InnerSettingSwitch(setting: settings4[index]),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
              ],
        ),
      ),
    );
  }
}