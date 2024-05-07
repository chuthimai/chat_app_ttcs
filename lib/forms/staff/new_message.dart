// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();


  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    // final enteredMessage = _messageController.text;
    //
    // if (enteredMessage
    //     .trim()
    //     .isEmpty) return;
    //
    // FocusScope.of(context).unfocus(); // dong moi ban phim dang mo
    // _messageController.clear();
    //
    // // Send to Firebase
    // final user = FirebaseAuth.instance.currentUser!;
    //
    // final userData = await FirebaseFirestore.instance.collection('users').doc(
    //     user.uid).get();
    //
    // FirebaseFirestore.instance.collection('chat').add({
    //   'text': enteredMessage,
    //   'createAt': Timestamp.now(),
    //   'userID': user.uid,
    //   'userName': userData.data()!['username'],
    //   'userImage': userData.data()!['image_url'],
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.image),
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.keyboard_voice),
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          ),
          Expanded(child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: "Send a message..."),
          )),
          IconButton(
            onPressed: _submitMessage,
            icon: Icon(Icons.send),
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          ),
        ],
      ),
    );
  }
}