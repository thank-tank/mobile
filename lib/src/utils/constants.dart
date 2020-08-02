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
    headline1: TextStyle(fontSize: 24.0, color: Colors.white),
    headline2: TextStyle(fontSize: 18.0, color: Colors.white),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText1: TextStyle(fontSize: 22.0, color: Colors.white),
    bodyText2: TextStyle(fontSize: 10.0, color: Colors.white),
    button: TextStyle(fontSize: 14.0, color: Colors.white),
  ),
);

const AWS_HOST = "http://54.153.13.255:8000/";
const LOCAL_HOST = "http://127.0.0.1:60620/";
//const BASE_URL = LOCAL_HOST;
const BASE_URL = AWS_HOST;

const URL_REGISTER = BASE_URL + "user/register";
const URL_LOGIN = BASE_URL + "user/login";
const URL_DROP = BASE_URL + "drop/";
const URL_DRIP = BASE_URL + "drop/drip";
const URL_OCEAN = BASE_URL + "drop/ocean";
const URL_OCEAN_TOTAL = BASE_URL + "drop/ocean/total";
