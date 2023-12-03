import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/profilesetting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<String?> getField(String field, String uid) async {
    try {
      // Replace 'your_collection_name' with the actual name of your Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');

      // Replace 'documentId' with the actual ID of the document you want to read
      DocumentSnapshot documentSnapshot = await collection.doc(uid).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Access and print the data
        String item = await documentSnapshot[field];
        return (item);
      } else {
        print('item not there');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Handle the case when the connection state is still waiting.
            return CircularProgressIndicator(); // or some other loading indicator
          } else if (snapshot.hasData) {
            final User? user = FirebaseAuth.instance.currentUser;

            return FutureBuilder(
              future: getField("username", user?.uid ?? 'empty'),
              builder: (context, fieldSnapshot) {
                if (fieldSnapshot.connectionState == ConnectionState.waiting) {
                  // Handle the case when the field data is still being fetched.
                  return CircularProgressIndicator(); // or some other loading indicator
                } else if (fieldSnapshot.hasError) {
                  // Handle the case when there is an error fetching the field data.
                  return Text('Error: ${fieldSnapshot.error}');
                } else {
                  if (fieldSnapshot.data == "") {
                    print(fieldSnapshot.data);
                    return profilesetting();
                  } else {
                    return const HomePage();
                  }
                }
              },
            );
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
