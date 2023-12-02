import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/components/button.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final contactController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void addContact(String contactEmail) async {
    User? user = _firebaseAuth.currentUser;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: contactEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String contactID = documentSnapshot.id;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .update({
          'contacts': FieldValue.arrayUnion([contactID])
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(contactID)
            .update({
          'contacts': FieldValue.arrayUnion([user?.uid])
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contact added successfully.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contact not found.'),
          ),
        );
      }
    } catch (e) {
      print('Error adding contact: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while adding the contact.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[900],
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Adding',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange[900]!,
            Colors.orange[800]!,
            Colors.orange[400]!
          ])),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 400,
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const CircleAvatar(
                  radius: 350,
                  backgroundImage: NetworkImage(
                      'https://cdn.discordapp.com/attachments/1035813890535206975/1180443968887078922/connect.png?ex=657d711d&is=656afc1d&hm=f96911fb1aed3c69e089c4bde490aee7ad34f31c1be55e1c930d147bee7b2046&'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.sizeOf(context).height - 496,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .3),
                            // spreadRadius: 5,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      width: 400,
                      child: MyTextField(
                          controller: contactController,
                          hintText: 'Enter friend"s email',
                          obscureText: false),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Color.fromARGB(255, 230, 81, 0),
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      width: 400,
                      child: MyButton(
                          onTap: () {
                            addContact(contactController.text);
                          },
                          text: "Add Contact"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
