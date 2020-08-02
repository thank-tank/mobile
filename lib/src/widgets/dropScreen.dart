import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:swim/src/utils/alerts.dart';
import 'package:swim/src/utils/constants.dart';
import 'package:swim/src/utils/utils.dart';

class DropScreen extends StatefulWidget {
  final String jwt;
  final String username;
  final String password;
  final int id;

  DropScreen(this.jwt, this.username, this.password, this.id);

  @override
  _DropScreenState createState() => _DropScreenState();
}

class _DropScreenState extends State<DropScreen> {
  final TextEditingController _commentController = new TextEditingController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Map<String, dynamic>> getDrop() async {
    final response = await http.get(URL_DROP + widget.id.toString() + "/");

    if (response.statusCode == 200) {
      final Map<String, dynamic> drop = json.decode(response.body);
      print(drop);
      return drop;
    } else {
      throw Exception('Failed to load ');
    }
  }

  void postComment(BuildContext context) async {
    var response = await http.post(URL_DROP_COMMENT,
        body:
            '{"username": "${widget.username}", "post_id":"${widget.id}", "content":"${_commentController.text}"}');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 201) {
      print("success");
      _commentController.clear();
    } else {
      showErrorDialog(context, "Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () { return getDrop(); },
      child: FutureBuilder(
        future: getDrop(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              body: Container(
                color: Theme.of(context).backgroundColor,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                snapshot.data['username'],
                                style: defaultTheme.textTheme.bodyText2,
                              ),
                              Spacer(),
                              Text(
                                parseDate(snapshot.data['pub_data']),
                                style: defaultTheme.textTheme.bodyText2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data['content'],
                            style: defaultTheme.textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (snapshot.data['post_feed'].length == 1)
                                ? "${snapshot.data['post_feed'].length} drip"
                                : "${snapshot.data['post_feed'].length} drips",
                            style: defaultTheme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.grey,
                                indent: 10,
                                endIndent: 10,
                              ),
                          itemCount: snapshot.data['post_feed'].length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextFormField(
                                        controller: _commentController,
                                        decoration: const InputDecoration(
                                          labelText: "drop a comment...",
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            postComment(context);
                                          },
                                          icon: Icon(Icons.send),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              int listIndex = index - 1;
                              return Padding(
                                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data['post_feed']
                                                [listIndex]['username'],
                                            style: defaultTheme
                                                .textTheme.bodyText2,
                                          ),
                                          Spacer(),
                                          Text(
                                            parseDate(snapshot.data['post_feed']
                                                [listIndex]['pub_data']),
                                            style: defaultTheme
                                                .textTheme.bodyText2,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data['post_feed'][listIndex]
                                            ['content'],
                                        style: defaultTheme.textTheme.bodyText1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            showErrorDialog(context, "uh oh: drop of gratitude failed");
            return Container();
          } else {
            return Container(
              child: SizedBox(
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
