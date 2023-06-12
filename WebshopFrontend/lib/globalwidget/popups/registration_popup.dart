import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> registrationDialog(BuildContext context) {
   const registrationWidth = 400.0;
   const registrationHeight = 400.0;

    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordRepeatController = TextEditingController();
    final emailController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const  Text("Registrieren", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        content: Container(
          height: registrationHeight,
          width: registrationWidth,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: firstNameController,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Vornamen',
                ),
              ),
              TextFormField(
                controller: lastNameController,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Nachnamen',
                ),
              ),
              TextFormField(
                controller: usernameController,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Benutzername',
                ),
              ),
              TextFormField(
                controller: emailController,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Email',
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Passwort',
                ),
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.alphabetic,
                      child: Icon(Icons.info_outline, size: 11,),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 5),
                    ),
                    TextSpan(
                      text: 'Das Passwort muss mindestest 10 Zeichen lang sein ',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: passwordRepeatController,
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Wiederhole dein Passwort:',
                ),
              ),
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
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}