import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobility_login/core/common/color.dart';
import '../../../chat/data/message.dart';
import '../../../chat/presentation/widget/chat_input_feed.dart';
import '../../../chat/presentation/widget/messeage_out.dart';
import '../../../first_page/presentation/first_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  Future<void> sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String? sender;
      if (user != null) {
        sender = user!.phoneNumber ?? user!.email;
      }
      if (sender != null) {
        await _firestore.collection('messages').add({
          'text': _controller.text,
          'sender': sender,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
      _controller.clear();
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const FirstPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text('Group Chat',
            style: TextStyle(
              color: ColorConst.blueAcc,
                fontSize: 30, fontWeight: FontWeight.w600)),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            style:   ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(ColorConst.blueAcc),
            ),
            onPressed: _signOut,
            child:   Text(
              "LogOut",
              style: TextStyle(color: ColorConst.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs
                    .map((doc) => Message(
                          sender: doc['sender'],
                          text: doc['text'],
                          isCurrentUser: user != null &&
                              (user!.email == doc['sender'] ||
                                  user!.phoneNumber == doc['sender']),
                        ))
                    .toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageOut(message: messages[index]);
                  },
                );
              },
            ),
          ),
          ChatInputField(controller: _controller, sendMessage: sendMessage),
        ],
      ),
    );
  }
}
