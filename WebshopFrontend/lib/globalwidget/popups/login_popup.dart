
import 'package:flutter/material.dart';

Future<void> loginDialog(BuildContext context) {
  const registrationWidth = 400.0;
  const registrationHeight = 300.0;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const  Text("Anmelden", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        content: SizedBox(
          height: registrationHeight,
          width: registrationWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Benutzername',
                ),
              ),
              TextFormField(
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Passwort',
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
            child: const Text('Anmelden'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}