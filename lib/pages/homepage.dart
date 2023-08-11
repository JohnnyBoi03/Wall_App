import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall_app/components/text_field.dart';
import 'package:wall_app/components/wall_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //Sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Text controller
  final textcontroller = TextEditingController();
  //Post message
  void postMessage() {
    if (textcontroller.text.isNotEmpty) {
      //store in firebase
      FirebaseFirestore.instance.collection('User Post').add({
        'UserEmail': currentUser.email,
        'Message': textcontroller.text,
        'TimeStamp': Timestamp.now()
      });
    }
    // clear textfield after post
    setState(() {
      textcontroller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('The Wall'),
        actions: [
          // sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
        backgroundColor: Colors.grey.shade800,
      ),
      body: Center(
        child: Column(
          children: [
            // the wall
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('User Post')
                    .orderBy('TimeStamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            // post message
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  //textfield
                  Expanded(
                    child: MyTextField(
                      controller: textcontroller,
                      hintText: 'write something on the wall...',
                      obscureText: false,
                    ),
                  ),
                  // post button
                  IconButton(onPressed: postMessage, icon: Icon(Icons.send)),
                ],
              ),
            ),

            //grab user
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Logged in as: ' + currentUser.email!),
            ),
          ],
        ),
      ),
    );
  }
}
