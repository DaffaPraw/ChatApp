import 'package:chat_app/pages/add_group.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/pages/add_contact.dart';

class AddOptions extends StatelessWidget {
  const AddOptions({super.key});

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
              MyButton(
                  icon: Icon(Icons.group_rounded),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddGroup()),
                    );
                  },
                  text: "Add a Group"),
              const SizedBox(height: 5),
              MyButton(
                  icon: Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddContact()),
                    );
                  },
                  text: "Add a Contact"),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
