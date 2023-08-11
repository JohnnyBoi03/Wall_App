// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String user;
  //final String time;
  final String message;
  const WallPost({super.key, required this.message, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15,
        top: 15,
      ),
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          // profile pic
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 8,bottom: 8,),
            child: Container(
              decoration: BoxDecoration( shape: BoxShape.circle, color: Colors.grey.shade400),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.person, color: Colors.white,),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                user,
                style: TextStyle(
                  fontSize: 15, color: Colors.grey
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
