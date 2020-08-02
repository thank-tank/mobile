import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:swim/src/utils/alerts.dart';
import 'package:swim/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:swim/src/widgets/chatScreen.dart';

class ChatFeed extends StatefulWidget {
  final String jwt;
  final String username;
  final String password;
  final String userId;

  ChatFeed(this.jwt, this.username, this.password, this.userId);

  @override
  _ChatFeedState createState() => _ChatFeedState();
}

class _ChatFeedState extends State<ChatFeed> {
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(URL_USERS);
    if (response.statusCode == 200) {
      final Map<String, dynamic> users = json.decode(response.body);
      print(users);
      return users['users'];
    } else {
      throw Exception('Failed to load ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                      indent: 10,
                      endIndent: 10,
                    ),
                itemCount: snapshot.data.length - 1,
                itemBuilder: (context, index) {
                  int newIndex = index;
                  if (snapshot.data[index]['username'] == widget.username) {
                    newIndex = snapshot.data.length - 1;
                  }
                  return Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      widget.username,
                                      widget.userId,
                                      snapshot.data[newIndex]['username'],
                                      snapshot.data[newIndex]['id'].toString(),
                                    )));
                      },
                      child: Container(
                        child: Text(
                          snapshot.data[newIndex]['username'],
                          style: defaultTheme.textTheme.headline1,
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          showErrorDialog(context, "uh oh: drop of gratitude failed");
          return Container();
        } else {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
