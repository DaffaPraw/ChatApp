import 'dart:io';

import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/services/image_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String imageUrl;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
    required this.imageUrl,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final image_service _image_service = image_service();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  String imageUrl = '';
  String? lastTappedMessage;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text, '',
          replyToMessage: lastTappedMessage);

      _messageController.clear();
      setState(() {
        lastTappedMessage = null;
      });
    }
  }

  void sendImage(image) async {
    await _chatService.sendMessage(widget.receiverUserID, '', image);

    // _messageController.clear();
  }

  void openMediaDialog() {
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
                      final ImagePicker _picker = ImagePicker();
                      final XFile? file =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (file != null) {
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          await referenceImageToUpload
                              .putFile(File(file!.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          // some error
                        }

                        sendImage(imageUrl);

                        _messageController.clear();
                      }
                    },
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? file =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          await referenceImageToUpload
                              .putFile(File(file!.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          // some error
                        }

                        sendImage(imageUrl);

                        _messageController.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
            ),
            const SizedBox(width: 8),
            Text(widget.receiverUserEmail),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.docs.isEmpty) {
          return Center(
              child: Text('This is a start of your new conversation!!'));
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            if (data['replyToMessage'] != null)
              ChatBubble(
                message: 'Replying to: ${data['replyToMessage']}',
                image: data['image'],
                isReply: true,
              ),
            GestureDetector(
              onTap: () {
                setState(() {
                  lastTappedMessage = data['message'];
                });
              },
              child: ChatBubble(
                message: data['message'],
                image: data['image'],
                isReply: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Enter Message',
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: openMediaDialog,
            icon: const Icon(
              Icons.add_photo_alternate,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
