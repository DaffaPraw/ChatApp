import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/contactList.dart';
import 'package:chat_app/pages/profile.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/setting/screen/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/pages/add_options.dart';

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
  }

  void settings() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SettingsScreen()), //Profile()
    );
  }

  Future<String> getContactEmail(String contactID) async {
    try {
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(contactID)
          .get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('email')) {
        return data['email'] as String;
      } else {
        print('Contact email not found.');
        return '';
      }
    } catch (e) {
      print('Error retrieving contact email: $e');
      return '';
    }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactList()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFECB365),
      ),
    );
  }
}

Widget _buildUserList() {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? currentUser = _firebaseAuth.currentUser;

  if (currentUser == null) {
    return const Text('User not authenticated');
  }

  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Text('Error fetching user data');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text('Loading...');
      }

      List<String> contactUserIds = [];
      List<String> groupIds = [];
      if (snapshot.data!.exists && snapshot.data!.data() != null) {
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        if (userData.containsKey('contacts') && userData['contacts'] != null) {
          contactUserIds = List<String>.from(userData['contacts']);
        }
        if (userData.containsKey('groups') && userData['groups'] != null) {
          groupIds = List<String>.from(userData['groups']);
        }
      }

      return ListView.builder(
        itemCount: contactUserIds.length + groupIds.length,
        itemBuilder: (context, index) {
          if (index < contactUserIds.length) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(contactUserIds[index])
                  .get(),
              builder: (context, contactSnapshot) {
                if (contactSnapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Error fetching contact data',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                if (contactSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Loading contact...',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                Map<String, dynamic> contactData =
                    contactSnapshot.data!.data() as Map<String, dynamic>;
                String contactEmail = contactData['email'];

                return ListTile(
                  title: Text(
                    contactEmail,
                    style: TextStyle(color: Color(0xFFECB365)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverUserEmail: contactEmail,
                          receiverUserID: contactUserIds[index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('groups')
                  .doc(groupIds[index - contactUserIds.length])
                  .get(),
              builder: (context, groupSnapshot) {
                if (groupSnapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Error fetching group data',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                if (groupSnapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Loading group...',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                Map<String, dynamic> groupData =
                    groupSnapshot.data!.data() as Map<String, dynamic>;
                String groupName = groupData['groupName'];

                return ListTile(
                  title: Text(
                    groupName,
                    style: TextStyle(color: Color(0xFFECB365)),
                  ),
                  onTap: () {},
                );
              },
            );
          }
        },
      );
    },
  );
}

class _StatusTab extends StatefulWidget {
  const _StatusTab({Key? key}) : super(key: key);

  @override
  _StatusTabState createState() => _StatusTabState();
}

class _StatusTabState extends State<_StatusTab> {
  @override
  Widget build(BuildContext context) {
    // Empty container for the Status tab
    return Container();
  }
}
