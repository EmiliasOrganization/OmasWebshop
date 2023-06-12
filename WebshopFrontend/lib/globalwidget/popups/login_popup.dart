import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> loginDialog(BuildContext context) {

  const loginWidth = 400.0;
  const loginHeight = 300.0;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const  Text("Anmelden", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
              SizedBox(height: 4),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              print('${usernameController.text} ${passwordController.text}');
             // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
