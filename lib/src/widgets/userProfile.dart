import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class UserProfile extends StatefulWidget {
  final String jwt;

  UserProfile(this.jwt);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "user profile"
      ),
      color: Colors.blue,
    );
  }
}
