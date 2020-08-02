import "package:flutter/material.dart";

var defaultTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlue[800],
  accentColor: Colors.cyan[600],
  backgroundColor: Color.fromRGBO(0, 0, 0, 100),
  buttonColor: Color.fromRGBO(107, 205, 244, 80),
  disabledColor: Colors.grey,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 20.0, color: Colors.white),
    headline2: TextStyle(fontSize: 16.0, color: Colors.white),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText1: TextStyle(fontSize: 22.0, color: Colors.white),
    bodyText2: TextStyle(fontSize: 10.0, color: Colors.white),
    button: TextStyle(fontSize: 14.0, color: Colors.white),
  ),
);

const AWS_HOST = "http://54.153.13.255:8000/";
const LOCAL_HOST = "http://127.0.0.1:8000/";
//const BASE_URL = LOCAL_HOST;
const BASE_URL = AWS_HOST;

const URL_REGISTER = BASE_URL + "user/register";
const URL_LOGIN = BASE_URL + "user/login";
const URL_POST = BASE_URL + "post/";
const URL_FEED = BASE_URL + "post/feed";
const URL_DROP = BASE_URL + "post/drop/";
const URL_DROP_COMMENT = BASE_URL + "post/response";
const URL_TOTAL_DROPS = BASE_URL + "post/total";
