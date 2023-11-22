import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/setting/models/setting.dart';
import 'package:chat_app/setting/widgets/avatar_card.dart';
import 'package:chat_app/setting/widgets/setting_tile.dart';
import 'package:chat_app/setting/widgets/support_card.dart';

class DataUsages extends StatefulWidget {
  const DataUsages({super.key});

  @override
  State<DataUsages> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<DataUsages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Usage'),
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
                    (index) => SettingTile(setting: settings5[index]),
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