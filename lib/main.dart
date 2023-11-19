import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/services/login_register.dart';
import 'package:chat_app/setting/models/setting.dart';
import 'package:chat_app/setting/screen/inner_setting/datausage.dart';
import 'package:chat_app/setting/screen/inner_setting/notification.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/setting/screen/setting_screen.dart';
import 'package:chat_app/setting/screen/inner_setting/personal.dart';
import 'package:chat_app/setting/screen/inner_setting/notification.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
    '/personal': (context) => const PersonalData(),
    '/notification': (context) => const Notifications(),
    '/datausage': (context) => const DataUsages(),
  },


      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,),
      home: const SettingsScreen(), //LoginOrRegister()
    );
  }
}
