import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/userdisplay.dart';
import 'package:chat_app/pages/profile.dart';
import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/auth/login_or_register.dart';
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

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthGate(),
      ),
    );
  }

  void settings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Chat'),
              Tab(text: 'Status'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ChatTab(),
            _StatusTab(),
          ],
        ),
      ),
    );
  }
}

class _ChatTab extends StatefulWidget {
  const _ChatTab({Key? key}) : super(key: key);

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<_ChatTab> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final image_service _image_service = image_service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      return ListTile(
        leading: ClipOval(
            child: Image.network(
          imageUrl.toString(),
          width: 50,
          height: 50,
        )),
        title: Text(data['username']),
        subtitle: Text(data['email']),
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

class _StatusTab extends StatefulWidget {
  const _StatusTab({Key? key}) : super(key: key);

  @override
  _StatusTabState createState() => _StatusTabState();
}

class _StatusTabState extends State<_StatusTab> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final image_service _image_service = image_service();

  Future<void> editUserField(String field, String update) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(user?.uid ?? 'empty').update({
        field: update,
      });

      print('Pfpurl updated successfully');
      setState(() {});
    } catch (e) {
      print('Error updating user pfpurl: $e');
    }
  }

  void openInputDialog(BuildContext context) {
    TextEditingController _inputController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Input field
              TextField(
                controller: _inputController,
                decoration: InputDecoration(labelText: 'Enter status'),
              ),
              SizedBox(height: 16.0), // Add some spacing

              // Button
              ElevatedButton(
                onPressed: () {
                  final Timestamp timestamp = Timestamp.now();
                  // Handle button press (you can use _inputController.text for the input value)
                  print('Input Value: ${_inputController.text}');
                  editUserField('status', '${_inputController.text}');
                  editUserField('timestamp', timestamp.toString());
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Set status'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add a CircleAvatar here

        ListTile(
          leading: Icon(Icons.gesture),
          title: Text("Update Status"),
          onTap: () {
            openInputDialog(context);
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              }

              return ListView(
                children: snapshot.data!.docs
                    .map<Widget>((doc) => FutureBuilder<Widget>(
                          future: _buildUserListItem(doc),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return snapshot.data!;
                            } else {
                              return const Text('loading user...');
                            }
                          },
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<Widget> _buildUserListItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (data['status'] != "") {
      String imageUrl =
          await _image_service.getPfpUrlId(data['uid'] ?? 'empty') ?? 'empty';

      return ListTile(
        leading: ClipOval(
            child: Image.network(
          imageUrl.toString(),
          width: 50,
          height: 50,
        )),
        title: Text(data['username']),
        subtitle: Text(data['status']),
        onTap: () {
          // const groupdisplay(
          //   email: '',
          //   username: '',
          //   pfpurl: '',
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => groupdisplay(
                      email: data['email'],
                      username: data['username'],
                      pfpurl: data['pfpurl'],
                    )),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
