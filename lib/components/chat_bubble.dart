import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String image;
  final bool isReply;

  const ChatBubble(
      {Key? key,
      required this.message,
      required this.image,
      this.isReply = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isReply ? Colors.grey : Colors.orange[500],
      ),
      child: Column(
        children: [
          if (image != '') ...[
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Image.network(image),
          ] else ...[
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}