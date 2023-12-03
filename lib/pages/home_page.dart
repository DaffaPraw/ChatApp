import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/profile.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/image_service.dart';
import 'package:chat_app/setting/screen/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final image_service _image_service = image_service();

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  void settings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()), //Profile()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: settings,
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => FutureBuilder<Widget>(
                    future: _buildUserListItem(doc),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return snapshot.data!;
                      } else {
                        return const Text('loading user...');
                      }
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  Future<Widget> _buildUserListItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      String imageUrl =
          await _image_service.getPfpUrlId(data['uid'] ?? 'empty') ?? 'empty';
      print(imageUrl);

      return ListTile(
        leading: ClipOval(
            child: Image.network(
          imageUrl.toString(),
          // "https://firebasestorage.googleapis.com/v0/b/chatapp-dfdd5.appspot.com/o/images%2Favatar-male.png?alt=media&token=24f15f9f-5eb4-4071-9b10-462a2b948353",
          width: 50,
          height: 50,
        )),
        title: Text(data['email']),
        onTap: () async {
          // print(imageUrl);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
                imageUrl: imageUrl,
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}