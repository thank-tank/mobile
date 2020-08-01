import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class HomeFeed extends StatefulWidget {
  final String jwt;

  HomeFeed(this.jwt);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Text(
        "home page"
      )
    );
  }
}
