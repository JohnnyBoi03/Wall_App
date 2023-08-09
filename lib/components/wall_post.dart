import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String user;
  //final String time;
  final String message;
  const WallPost({super.key, required this.message, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(user),
            Text(message),
          ],
        )
      ],
    );
  }
}
