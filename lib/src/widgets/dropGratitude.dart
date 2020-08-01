import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class DropGratitude extends StatefulWidget {
  final String jwt;

  DropGratitude(this.jwt);

  @override
  _DropGratitudeState createState() => _DropGratitudeState();
}

class _DropGratitudeState extends State<DropGratitude> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Text(
        "Drop gratitude"
      )
    );
  }
}
