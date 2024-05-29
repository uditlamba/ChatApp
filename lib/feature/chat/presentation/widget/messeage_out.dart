import 'package:flutter/material.dart';
import '../../../../core/common/color.dart';
import '../../data/message.dart';

class MessageOut extends StatelessWidget {
  final Message message;

  const MessageOut({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: message.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: message.isCurrentUser ? ColorConst.blue : ColorConst.black,
            ),
          ),
          Container(
            margin: message.isCurrentUser
                ? const EdgeInsets.only(left: 40)
                : const EdgeInsets.only(right: 40),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: message.isCurrentUser ? ColorConst.blueAcc : ColorConst.grey300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                fontSize: 20,
                color: message.isCurrentUser ? ColorConst.white : ColorConst.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}