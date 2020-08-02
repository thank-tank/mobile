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
  final TextEditingController _dripController = new TextEditingController();
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

  void postDrip(BuildContext context) async {
    var response = await http.post(URL_DRIP,
        body:
            '{"username": "${widget.username}", "drop_id":"${widget.id}", "content":"${_dripController.text}"}');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 201) {
      print("success");
      _dripController.clear();
    } else {
      showErrorDialog(context, "Failed to post drip");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () {
        return getDrop();
      },
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
                            "\"${snapshot.data['content']}\"",
                            style: defaultTheme.textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (snapshot.data['drip_stream'].length == 1)
                                ? "${snapshot.data['drip_stream'].length} drip"
                                : "${snapshot.data['drip_stream'].length} drips",
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
                          itemCount: snapshot.data['drip_stream'].length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextFormField(
                                        controller: _dripController,
                                        decoration: const InputDecoration(
                                          labelText: "drip a comment...",
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            postDrip(context);
                                          },
                                          icon: ImageIcon(
                                            AssetImage("assets/img/water.png"),
                                          ),
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
                                            snapshot.data['drip_stream']
                                                [listIndex]['username'],
                                            style: defaultTheme
                                                .textTheme.bodyText2,
                                          ),
                                          Spacer(),
                                          Text(
                                            parseDate(
                                                snapshot.data['drip_stream']
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
                                        snapshot.data['drip_stream'][listIndex]
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
