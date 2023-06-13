import 'package:flutter/material.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import '../../../../globalwidget/popups/login_popup.dart';
import '../../../../globalwidget/top_bar.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return CenteredView(
        child: Scaffold(
          appBar: TopBar(ueberUns: false),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Willkommen zurück!',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 400,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: usernameController,
                                    autocorrect: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: 'Nutzername',
                                        border: UnderlineInputBorder()),
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    autocorrect: false,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: 'Passwort',
                                        border: UnderlineInputBorder()),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHight*0.01),
                          ],
                        ),
                      ],
                    ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(width: 400),
                              Container(
                                  width: 200,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        String username = usernameController.text;
                                        String password = passwordController.text;
                                        int result = await LoginCommunication().loginUser(username, password);
                                        print(result);
                                        if (result == 200) {
                                          print('die Anmeldung war erfolgreich');
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
                                      child: Text('Anmelden')
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    SizedBox(height: screenHight*0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Neu hier?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHight*0.02),
                            Row(
                              children: [
                                Container(
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: (){},
                                        child: Text('Registrieren'))
                                ),
                                SizedBox(width: screenWidth*0.01),
                                Container(
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: (){},
                                        child: Text('Als Gast fortfahren'))
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],),
                )
              ),
            ],
          )
        )
      );
  }
}