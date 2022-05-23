import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageTextController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

  void getCurrentuser() async {
    try {
      // ignore: await_only_futures
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // ignore: avoid_print
        print(loggedInUser.email);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('message').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: const Text('chat'),
        actions: [
          
          ElevatedButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('message').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data?.docs.reversed;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages!) {
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');

                  final currentUser = loggedInUser.email;

                  // if(currentUser == messageSender){

                  // }
                  // ignore: non_constant_identifier_names
                  final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isme: currentUser == messageSender,
                  );
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messageBubbles,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: ' Type your messsage here ...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                controller: MessageTextController,
                onChanged: (value) {
                  messageText = value;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // ignore: avoid_print
                MessageTextController.clear();
                _firestore.collection("message").add({
                  'text': messageText,
                  'sender': loggedInUser.email,
                });
              },
              child: const Text('send'),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  // const MessageBubble({ Key? key }) : super(key: key);
  final String? sender;
  final String? text;
  final bool isme;
  MessageBubble({this.sender, this.text,required this.isme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender!,
            style: const TextStyle(fontSize: 14, color: Colors.black45),
          ),
          Material(
            borderRadius:  isme ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)): const BorderRadius.only(
                topRight: Radius.circular(30),

                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: isme ? Colors.lightBlueAccent : Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$text ',
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
