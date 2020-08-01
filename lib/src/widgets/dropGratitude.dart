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
    var response = await http.post(URL_POST,
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
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "drop some gratitude",
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
                  // send HTTP Post request to backend to create drop of gratitude
                  // constants.dart
                },
                child: Image(
                  image: AssetImage('assets/img/water.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
