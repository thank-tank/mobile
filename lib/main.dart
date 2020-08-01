import 'package:flutter/material.dart';
import 'package:swim/src/onboard/welcome.dart';
import 'package:swim/src/utils/constants.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => Welcome(),
      }
    )
  );
}
