import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/globalwidget/popups/login_popup.dart';
import 'package:flutterfrontend/globalwidget/popups/registration_popup.dart';

class LoginButton extends StatelessWidget {
  static const List<String> choices = <String>[
    'Anmelden',
    'Registrieren',
  ];

  @override
  Widget build(BuildContext context) {
    return  IconButton(
          icon: Icon(Icons.person),
          color: schemeColorGreen,
          onPressed: () {
            showPopupMenu(context);
          },
    );
  }

  void showPopupMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, 50), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: choices.map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice),
        );
      }).toList(),
    ).then((String? choice) {
      if (choice != null) {
        choiceAction(choice,context);
      }
    });
  }

  void choiceAction(String choice, BuildContext context) {
    if (choice == "Anmelden") {
      loginDialog(context);
    } else if (choice == "Registrieren") {
      registrationDialog(context);
    }
  }
}