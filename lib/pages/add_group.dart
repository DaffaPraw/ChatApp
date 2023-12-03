import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/components/button.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final groupController = TextEditingController();
  bool isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> makeEmptyGroup(String groupName) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    Map<String, dynamic> group = {
      'groupName': groupName,
      'admin': currentUserId,
      'members': FieldValue.arrayUnion([currentUserId])
    };

    await _fireStore.collection('groups').add(group);

    await _fireStore.collection('users').doc(currentUserId).update({
      'groups(user)': FieldValue.arrayUnion([groupName])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF041C32),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              const SizedBox(height: 30),
              MyTextField(
                  controller: groupController,
                  hintText: 'Enter group"s name',
                  obscureText: false),
              MyButton(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await makeEmptyGroup(groupController.text);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  text: "Make Group"),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
