
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:http/http.dart' as http;
import '../../constats.dart';

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
        content: SizedBox(
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
            child: const Text('Registrieren'),
            onPressed: () async {
              String firstName = firstNameController.text;
              String lastname = lastNameController.text;
              String username = usernameController.text;
              String password = passwordController.text;
              String passwordRepeat = passwordRepeatController.text;
              String email = emailController.text;
              int result = await RegistrationCommunication().registerUser(firstName, lastname, username, password, passwordRepeat, email);
              print(result);
              if (result == 200) {
                Navigator.of(context).pop();
                print('Registrierung erfolgreich');
              }
              if (result == 401) {
                print("error");
                //TODO: check error if password and passwordRepeat aren't similar
              }
              // else {
              //   setState(() {
              //     errorMessage = 'Something went wrong.';
              //   });
              // }
            },
          ),
        ],
      );
    },
  );
}

class RegistrationCommunication {
  Future<int> registerUser(String firstName, String lastname, String username, String password, passwordRepeat, email) {
    final body = jsonEncode({
      'firstname': firstName,
      'lastname': lastname,
      'username': username,
      'password': password,
      'passwordRepeat': passwordRepeat,
      'email': email,
    });

    return http.post(Uri.parse(authApiRegister),
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
