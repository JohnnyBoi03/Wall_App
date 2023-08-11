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
        bottom: 20,
        left: 20,
        right: 20,
        top: 20,
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
