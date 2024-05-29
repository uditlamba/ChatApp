import 'package:flutter/material.dart';

import '../../../../core/common/color.dart';

class CustomBottomSheet {
  static Widget create(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your Message',
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Container(
            decoration: BoxDecoration(
              color: ColorConst.blueAcc,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon:   Icon(
                Icons.send,
                size: 35,
                color: ColorConst.white,
              ),
              onPressed: () {
                // Perform some action
              },
            ),
          )
        ],
      ),
    );
  }
}
