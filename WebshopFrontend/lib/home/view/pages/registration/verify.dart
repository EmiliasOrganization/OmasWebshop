import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constats.dart';

class Verify extends StatefulWidget {
  final String token;
  const Verify({Key? key, required this.token}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  late String verificationStatus;

  @override
  void initState() {
    super.initState();
    verificationStatus = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifizierung'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Token: ${widget.token}',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              child: Text('Token überprüfen'),
              onPressed: () {
                _verifyToken();
              },
            ),
            SizedBox(height: 16),
            Text(
              verificationStatus,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyToken() async {
    try {
      final response = await http.get(Uri.parse('$authApiVerify/${widget.token}'));


      if (response.statusCode == 200) {
        setState(() {
          verificationStatus = 'Token erfolgreich überprüft';
        });
      } else if (response.statusCode == 404) {
        setState(() {
          verificationStatus = 'Ungültiger Token';
        });
      } else {
        setState(() {
          verificationStatus = 'Ein unerwarteter Fehler ist aufgetreten';
        });
      }
    } catch (e) {
      setState(() {
        verificationStatus = 'Fehler beim Verbinden mit dem Backend $e';
      });
    }
  }
}