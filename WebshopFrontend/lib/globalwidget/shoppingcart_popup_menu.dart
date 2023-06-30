import 'package:flutter/material.dart';

import '../boxes.dart';
import '../constats.dart';

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      icon: Icon(Icons.shopping_cart),
      color: schemeColorGreen,
      onPressed: () {
        showShoppingCartElements(context);
      },
    );
  }

  showShoppingCartElements(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    List <PopupMenuItem<String>> _itemList = [];

    // to Ckeckout List Element
    _itemList.add(
      PopupMenuItem<String>(
        value: 'checkout',
        child: ListTile(
          leading: Text('Zur Kasse'),
          trailing: ElevatedButton(
            onPressed: () {
              // Handle the button click event here
              // For example, navigate to the checkout screen
            },
            child: Text('Bezahlen'),
          ),
        ),
        enabled: false,
      ),
    );

    getItems() async {

      _itemList.addAll(boxItemLists.values.map((e) => PopupMenuItem<String>(value: e.id , child: Text(e.name),)).toList());
    }

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, 50), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    getItems();
    showMenu<String>(
      context: context,
      position: position,
      items: _itemList

    );

  }

}
