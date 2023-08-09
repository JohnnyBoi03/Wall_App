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
  void postMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Wall'),
        actions: [
          // sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
        backgroundColor: Colors.grey.shade900,
      ),
      body: Center(
        child: Column(
          children: [
            // the wall
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('User Posts')
                        .orderBy('TimeStamp', descending: false)
                        .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData){
                            return ListView.builder(itemBuilder: (context, index){ 
                              // get the message
                              final post=snapshot.data!.docs[index];
                              return WallPost(message: post['message'], user: post['UserEmail'],);
                            });
                          } else if (snapshot.hasError){
                            return Center(
                              child: Text('Error:${snapshot.error}'),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        )),
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
                        obscureText: false),
                  ),
                  // post button
                  IconButton(onPressed: () {}, icon: Icon(Icons.send))
                ],
              ),
            ),

            //grab user
            Text('Logged in as: ' + currentUser.email!),
          ],
        ),
      ),
    );
  }
}
