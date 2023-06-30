import 'package:flutter/material.dart';

import '../boxes.dart';
import '../constats.dart';

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          color: schemeColorGreen,
          onPressed:() {
            showShoppingCartElements(context);
          },
        ),
        if(boxItemLists.length > 0)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Text(
              boxItemLists.length.toString(),
              style: TextStyle(
                color: schemeColorGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

      ],
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
        enabled: false,
        child: ListTile(
          leading: Text('Zur Kasse'),
          trailing: ElevatedButton(
            onPressed: ()
            {
              Navigator.pushNamed(context, '/shoppingCart');
            },
            child: Text('Bezahlen'),
          ),
        ),
      ),
    );

    emptyShoppingCart()
    {
      _itemList.add(
        PopupMenuItem<String>(
          value: 'checkout',
          enabled: false,
          child: ListTile(
            title: Text(
              'Dein Warenkorb ist leer. Füge Produkte hinzu.',
              style: TextStyle(fontSize: 18),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // Hier kannst du die Aktion definieren, die beim Drücken des Buttons ausgeführt wird
              },
              child: Text('Zum Shop'),
            ),
          )
        ),
      );
    }

    getItems() async {

      _itemList.addAll(boxItemLists.values.map((e) => PopupMenuItem<String>(value: e.id , child: Text(e.name),)).toList());
      if(_itemList.length <= 1){
        _itemList.removeLast();
        emptyShoppingCart();
      }
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
