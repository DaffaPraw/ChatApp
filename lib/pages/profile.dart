import 'dart:io';

import 'package:chat_app/pages/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl = '';

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? file =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (file != null) {
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images');

                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      try {
                        await referenceImageToUpload.putFile(File(file!.path));

                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        // some error
                      }
                    }
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                Text("Blastoise"),
                Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 55, vertical: 25),
                    padding: EdgeInsets.all(5),
                    child: Row(children: [
                      Icon(Icons.mail, color: Colors.blueAccent),
                      SizedBox(width: 25),
                      Text("Janson@gmail.com")
                    ]))
              ],
            ),
          )),
        ),
      ),
    );
  }
}
