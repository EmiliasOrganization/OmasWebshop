
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constats.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final loginWidth = 400.0;
  final loginHeight = 300.0;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: const Text("Anmelden",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      content: Container(
        height: loginHeight,
        width: loginWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: usernameController,
              autocorrect: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Benutzername/ Email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              autocorrect: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Passwort',
              ),
            ),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme
                .of(context)
                .textTheme
                .labelLarge,
          ),
          child: const Text('Anmelden'),
          onPressed: () async {
            String username = usernameController.text;
            String password = passwordController.text;
            int result = await LoginCommunication().loginUser(username, password);
            print(result);
            if (result == 200) {
              Navigator.of(context).pop();
            }
            if (result == 401) {
              setState(() {
                errorMessage = 'Username or Password incorrect.';
              });
            }
            else {
              setState(() {
                errorMessage = 'Something went wrong.';
              });
            }
          },
        ),
      ],
    );
  }
}

Future<void> loginDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return LoginDialog();
    },
  );
}

class LoginCommunication {
  Future<int> loginUser(String username, String password) {
    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    return http.post(Uri.parse(authApiLogin),
      headers: {'Content-Type': 'application/json'},
      body: body,
    ).then((response) {
      return Future.value(response.statusCode);
    }).catchError((error) {
      print(error);
      return Future.value(500);
    });
  }
}
