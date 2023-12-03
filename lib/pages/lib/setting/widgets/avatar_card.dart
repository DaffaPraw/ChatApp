import 'dart:io';

import 'package:chat_app/services/image_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class AvatarCard extends StatefulWidget {
  final String useremail;
  const AvatarCard({
    super.key,
    required this.useremail,
  });

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  String? imageUrl;
  String? username;

  final image_service _image_service = image_service();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Your code to run when the page is opened or updated
    if (ModalRoute.of(context)!.isCurrent) {
      username = await getField('username');
      imageUrl = await getField('pfpurl');
      setState(() {});
    }
  }

  Future<String?> getImage(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);

      try {
        await referenceImageToUpload.putFile(File(file!.path));
        imageUrl = await referenceImageToUpload.getDownloadURL();
      } catch (error) {
        // some error
      }

      return (imageUrl);
    }
  }

  Future<void> editFieldItem(String field, String item) async {
    try {
      // Replace 'users' with the actual name of your Firestore collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Update the 'email' field of the specified user document
      await usersCollection.doc(user?.uid ?? 'empty').update({
        field: item,
      });

      print('item updated successfully');
      setState(() {});
    } catch (e) {
      print('Error updating user item: $e');
    }
  }

  void openMediaDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Choose'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      String? imagePath = await getImage(ImageSource.camera);

                      // Check if imagePath is not null before calling editUserPfp
                      if (imagePath != null) {
                        editFieldItem("pfpurl", await imagePath);
                      } else {
                        print(
                            'Image path is null. Cannot update user profile picture.');
                      }
                    },
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String? imagePath = await getImage(ImageSource.gallery);

                      // Check if imagePath is not null before calling editUserPfp
                      if (imagePath != null) {
                        editFieldItem("pfpurl", await imagePath);
                      } else {
                        print(
                            'Image path is null. Cannot update user profile picture.');
                      }
                    },
                    child: Icon(
                      Icons.aspect_ratio,
                      size: 30,
                    ),
                  ),
                ],
              ));
        });
  }

  Future<String?> getField(String field) async {
    try {
      // Replace 'your_collection_name' with the actual name of your Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');

      // Replace 'documentId' with the actual ID of the document you want to read
      DocumentSnapshot documentSnapshot =
          await collection.doc(user?.uid ?? 'empty').get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Access and print the data
        String item = await documentSnapshot[field];
        setState(() {});
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
    return Row(
      children: [
        InkWell(
          onTap: () async {
            // print(user?.uid ?? 'empty');

            openMediaDialog();
            imageUrl = await getField('pfpurl');
            setState(() {});

            // print(await getPfpUrl());
          },
          child: CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.red,
            backgroundImage: NetworkImage(imageUrl ?? 'empty'),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                setState(() {});
                TextEditingController _inputController =
                    TextEditingController();

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Change username'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Input field
                          TextField(
                            controller: _inputController,
                            decoration:
                                InputDecoration(labelText: 'Enter username'),
                          ),
                          SizedBox(height: 16.0), // Add some spacing

                          // Button
                          ElevatedButton(
                            onPressed: () {
                              final Timestamp timestamp = Timestamp.now();
                              // Handle button press (you can use _inputController.text for the input value)
                              print('Input Value: ${_inputController.text}');
                              editFieldItem(
                                  'username', '${_inputController.text}');

                              print('masih jalan');
                              Navigator.of(context).pop(); // Close the dialog

                              print('ini juga masih jalan');
                              setState(() {});
                            },
                            child: Text('Set username'),
                          ),
                        ],
                      ),
                    );
                  },
                );
                print('ini jalan juga ga sih');
                username = await getField('username');
              },
              child: Text(
                username ?? 'empty',
                style: TextStyle(
                  fontSize: kbigFontSize,
                  fontWeight: FontWeight.bold,
                  color: kprimaryColor,
                ),
              ),
            ),
            Text(
              widget.useremail,
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
