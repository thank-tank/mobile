import 'dart:io' show Platform;
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

void showErrorDialog(BuildContext context, String body) {
  String title = "Error";
  String optionLabel = "Close";

  if (Platform.isIOS) {
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text(optionLabel),
          ),
        ],
      ),
    );
  } else if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          FlatButton(
            child: Text(optionLabel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
