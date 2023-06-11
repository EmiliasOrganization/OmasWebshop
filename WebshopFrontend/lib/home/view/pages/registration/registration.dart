import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  final registrationWidth = 400.0;

  @override
  Widget build(BuildContext context) {
    return CenteredView(
      child: Scaffold(appBar: TopBar(ueberUns: false),
          body: Center(
            child: Container(
              width: registrationWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Registrieren", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: '*Vornamen',
            ),
          ),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: '*Nachnamen',
            ),
          ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '*Benutzername',
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
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
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
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
          ),
      ),
    );
  }

}

