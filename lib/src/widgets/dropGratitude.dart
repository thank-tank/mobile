import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:swim/src/utils/alerts.dart';
import 'package:swim/src/utils/constants.dart';

class DropGratitude extends StatefulWidget {
  final String jwt;
  final String username;
  final String password;

  DropGratitude(this.jwt, this.username, this.password);

  @override
  _DropGratitudeState createState() => _DropGratitudeState();
}

class _DropGratitudeState extends State<DropGratitude> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = new TextEditingController();

  void postDrop(BuildContext context) async {
    var response = await http.post(URL_DROP,
        body:
            '{"content": "${_textController.text}", "username": "${widget.username}", "password":"${widget.password}"}');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 201) {
      print("success");
      _textController.clear();
    } else {
      showErrorDialog(context, "uh oh: drop of gratitude failed");
    }
  }

  Future<String> getDrops() async {
    var response = await http.get(URL_OCEAN_TOTAL);
    print('Get Drops Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> ret = json.decode(response.body);
      return ret['total'].toString();
    } else {
      showErrorDialog(context, "uh oh: drop of gratitude failed");
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.fromLTRB(70, 100, 70, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "drop some gratitude",
                labelStyle: TextStyle(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 100,
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: InkWell(
                onTap: () {
                  postDrop(context);
                },
                child: Image(
                  image: AssetImage('assets/img/water.png'),
                ),
              ),
            ),
            Spacer(),
            FutureBuilder(
              future: getDrops(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Text(
                    "0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "drops donated",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
