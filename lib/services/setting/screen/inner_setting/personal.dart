import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/setting/models/setting.dart';
import 'package:chat_app/setting/widgets/avatar_card.dart';
import 'package:chat_app/setting/widgets/setting_tile.dart';
import 'package:chat_app/setting/widgets/support_card.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<PersonalData> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> editData(String field, String data) async {
    try {
      // Replace 'users' with the actual name of your Firestore collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Update the 'email' field of the specified user document
      await usersCollection.doc(user?.uid ?? 'empty').update({
        field: data,
      });

      print('Pfpurl updated successfully');
      setState(() {});
    } catch (e) {
      print('Error updating user pfpurl: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarCard(useremail: user?.email ?? 'empty'),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(
                    settings.length,
                    (index) => SettingTile(
                      setting: settings3[index],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
