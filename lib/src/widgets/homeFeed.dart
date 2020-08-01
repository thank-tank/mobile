import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:swim/src/utils/constants.dart';

class HomeFeed extends StatefulWidget {
  final String jwt;

  HomeFeed(this.jwt);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  Future<Map<String, dynamic>> getFeed() async {
    final response = await http.get(URL_FEED);

    if (response.statusCode == 200) {
      var feed = json.decode(response.body);
      print(feed);
      Map<String, dynamic> feedParsed = Map<String, dynamic>();
      return feedParsed['feed'];
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
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: snapshot.data.feed.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text("Index $index")),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
        } else {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
