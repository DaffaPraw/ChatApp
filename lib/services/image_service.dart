import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as Path;

class image_service {
  User? user = FirebaseAuth.instance.currentUser;
  Future<String?> getImage(source) async {
    String imageUrl = "";
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
        String pfpurl = documentSnapshot['pfpurl'];
        return (pfpurl);
      } else {
        print('pfp not there');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  Future<String?> getPfpUrlId(String uid) async {
    try {
      // Replace 'your_collection_name' with the actual name of your Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');

      // Replace 'documentId' with the actual ID of the document you want to read
      DocumentSnapshot documentSnapshot =
          await collection.doc(uid ?? 'empty').get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Access and print the data
        String pfpurl = documentSnapshot['pfpurl'];
        return (pfpurl);
      } else {
        print('pfp not there');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }
}
