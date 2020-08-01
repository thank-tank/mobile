import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swim/src/onboard/home.dart';
import 'package:swim/src/utils/alerts.dart';
import 'package:swim/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class Auth extends StatefulWidget {
  Auth();

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  String usernameValidator(String value) {
    if (value.isEmpty) {
      return "Username empty";
    } else if (value.length < 4) {
      return "Username must contain at least 4 characters";
    }
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) {
      return "Password empty";
    } else if (value.length < 8) {
      return "Password must contain at least 8 characters";
    }
    return null;
  }

  void login(BuildContext context) async {
    var response = await http.post(URL_LOGIN,
        body:
            '{"username": "${_usernameController.text}", "password":"${_passwordController.text}"}');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home("fake jwt", _usernameController.text, _passwordController.text)));
    } else {
      showErrorDialog(context, "Invalid credentials");
    }
  }

  void register(BuildContext context) async {
    var response = await http.post(URL_REGISTER,
        body:
            '{"username": "${_usernameController.text}", "password":"${_passwordController.text}"}');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 201) {
      login(context);
    } else {
      showErrorDialog(context, "Username not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.fromLTRB(70, 100, 70, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: 100,
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Image(image: AssetImage('assets/img/water.png'))),
              Spacer(),
              TextFormField(
                validator: (value) => usernameValidator(value),
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),
              TextFormField(
                validator: (value) => passwordValidator(value),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CupertinoButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    login(context);
                  }
                },
                color: Theme.of(context).buttonColor,
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CupertinoButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    register(context);
                  }
                },
                color: Theme.of(context).buttonColor,
                child: Text(
                  "Register",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
