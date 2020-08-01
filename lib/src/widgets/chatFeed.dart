import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class ChatFeed extends StatefulWidget {
  final String jwt;

  ChatFeed(this.jwt);

  @override
  _ChatFeedState createState() => _ChatFeedState();
}

class _ChatFeedState extends State<ChatFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Text(
        "Chat Feed"
      )
    );
  }
}
