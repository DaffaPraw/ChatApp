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

  final image_service _image_service = image_service();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Your code to run when the page is opened or updated
    if (ModalRoute.of(context)!.isCurrent) {
      imageUrl = await getPfpUrl();
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

  Future<void> editUserPfp(String newpfpurl) async {
    try {
      // Replace 'users' with the actual name of your Firestore collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Update the 'email' field of the specified user document
      await usersCollection.doc(user?.uid ?? 'empty').update({
        'pfpurl': newpfpurl,
      });

      print('Pfpurl updated successfully');
      setState(() {});
    } catch (e) {
      print('Error updating user pfpurl: $e');
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
                        editUserPfp(await imagePath);
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
                        editUserPfp(await imagePath);
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

  Future<String?> getPfpUrl() async {
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
        String pfpurl = await documentSnapshot['pfpurl'];
        return (pfpurl);
        setState(() {});
      } else {
        print('pfp not there');
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
            imageUrl = await getPfpUrl();
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
            Text(
              widget.useremail,
              style: TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              "Halo Saya User!",
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
