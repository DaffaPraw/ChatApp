import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/image_service.dart';
import 'package:chat_app/setting/screen/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contactList.dart';
import "groupDisplay.dart";

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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange[900],
          title: const Text('ChatinAja'),
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
            indicatorColor: Colors.white,
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
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        List<String> contactUserIds = [];
        List<String> groupIds = [];
        if (snapshot.data!.exists && snapshot.data!.data() != null) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          if (userData.containsKey('contacts') &&
              userData['contacts'] != null) {
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

                    return FutureBuilder<String?>(
                      future: _image_service
                          .getPfpUrlId(contactData['uid'] ?? 'empty'),
                      builder: (context, imageUrlSnapshot) {
                        if (imageUrlSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Loading image...',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }

                        String imageUrl = imageUrlSnapshot.data ?? 'empty';

                        return ListTile(
                          leading: ClipOval(
                              child: Image.network(
                            imageUrl.toString(),
                            width: 50,
                            height: 50,
                          )),
                          title: Text(
                            contactEmail,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  receiverUserEmail: contactEmail,
                                  receiverUserID: contactUserIds[index],
                                  imageUrl: imageUrl,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              } else {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
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

                    if (groupSnapshot.connectionState ==
                        ConnectionState.waiting) {
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

                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    List<dynamic> groupNames = userData['groups'];

                    return ListTile(
                      title: Text(
                        groupNames.join(', '),
                        style: TextStyle(color: Color(0xFFECB365)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => groupDisplay()),
                        );
                      },
                    );
                  },
                );
              }
            });
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
    return Scaffold(
      appBar: null, // Set the appBar to null to remove it
      body: Column(
        children: [
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
      ),
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
          ),
        ),
        title: Text(data['username']),
        subtitle: Text(data['status']),
        onTap: () {
          print("listtile running");
          // Navigator.push(
          //   context,
          //   // Your navigation code here
          // );
        },
      );
    } else {
      return Container();
    }
  }
}