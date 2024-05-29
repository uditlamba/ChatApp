import 'package:flutter/material.dart';

import '../../../../core/common/color.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback sendMessage;

  const ChatInputField({super.key, required this.controller, required this.sendMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: ColorConst.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorConst.blueAcc,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon:   Icon(
                Icons.send,
                size: 35,
                color: ColorConst.white,
              ),
              onPressed: sendMessage,

            ),
          ),
        ],
      ),
    );
  }
}