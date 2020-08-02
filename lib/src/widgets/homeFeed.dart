import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:swim/src/utils/alerts.dart';
import 'package:swim/src/utils/constants.dart';
import 'package:swim/src/utils/utils.dart';
import 'package:swim/src/widgets/dropScreen.dart';

class HomeFeed extends StatefulWidget {
  final String jwt;
  final String username;
  final String password;

  HomeFeed(this.jwt, this.username, this.password);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {

  Future<Map<String, dynamic>> getFeed() async {
    final response = await http.get(URL_OCEAN);
    if (response.statusCode == 200) {
      final Map<String, dynamic> feed = json.decode(response.body);
      print(feed);
      return feed;
    } else {
      throw Exception('Failed to load ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFeed(),
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
              itemCount: snapshot.data['ocean'].length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DropScreen(
                                "fake jwt",
                                widget.username,
                                widget.password,
                                snapshot.data['ocean'][index]['id'])));
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              snapshot.data['ocean'][index]['username'],
                              style: defaultTheme.textTheme.bodyText2,
                            ),
                            Spacer(),
                            Text(
                              parseDate(
                                  snapshot.data['ocean'][index]['pub_data']),
                              style: defaultTheme.textTheme.bodyText2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data['ocean'][index]['content'],
                          style: defaultTheme.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          (snapshot.data['ocean'][index]['drip_stream'].length ==
                                  1)
                              ? "${snapshot.data['ocean'][index]['drip_stream'].length} drip"
                              : "${snapshot.data['ocean'][index]['drip_stream'].length} drips",
                          style: defaultTheme.textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
