import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../boxes.dart';
import '../constats.dart';

class ShoppingCartButton extends StatefulWidget {

  @override
  _ShoppingCartButtonState createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          color: schemeColorGreen,
          onPressed: () {
            showShoppingCartElements(context);
          },
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: boxItemLists.isNotEmpty
              ? Container(
            key: ValueKey<int>(boxItemLists.length),
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
          )
              : SizedBox.shrink(),
        ),
      ],
    );

  }

  showShoppingCartElements(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    List <PopupMenuItem<String>> _itemList = [];

    double sum = 0;

    boxItemLists.values.toList().forEach((element) { sum += double.parse(element.price); });

    //String price = sum.toString();

    // to Ckeckout List Element
    _itemList.add(
      PopupMenuItem<String>(
        value: 'checkout',
        enabled: false,
        child: ListTile(
          title: Text('Dein Einkaufswagen',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 14),),
          subtitle: Text('${boxItemLists.length} Artikel hinzufgefügt',
            style: TextStyle(
                fontSize: 16),),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$sum €',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10,),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/shoppingCart');
                },
                child: Text('Zur Kasse'),
              ),
            ],
          ),

        ),
      ),
    );

    emptyShoppingCart()
    {
      _itemList.add(
        PopupMenuItem<String>(
          value: 'noProduct',
          enabled: false,
          child: SizedBox(
            width: double.infinity,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Icon(
                      Icons.shopping_cart,
                      color: schemeColorGreen,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 20,),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'DEIN WARENKORB IST LEER',
                      style: TextStyle(
                        color: schemeColorGreen,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Finde schöne Produkte die zu dir passen.',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  SizedBox(height: 10,),
                  OutlinedButton(
                      onPressed: ()
                  {
                      Navigator.pushNamed(context, '/shop');
                  },

                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      child: Text('Zum Shop', style: TextStyle(fontSize: 25),) ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02)
                ],
              ),
            ),
          ),
        )
      );
    }
    createElementTile(String name, String id, String price){
      return ListTile(
        leading: CachedNetworkImage(
          imageUrl: '$shopApi/picture/$id/image1',
          placeholder: (context, url) =>
              CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: 50,
          width: 50,
          fit: BoxFit.fitHeight,),
        title: Text(name),
        subtitle: Row(
          children: [
            TextButton(
              style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                       overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          ),
                onPressed: ()
            {
                boxItemLists.delete(id);
            },
                child: Text('Entfernen')),
          ],

        ),
        trailing: Text('$price€', style: TextStyle(fontSize: 15),),
      );
    }

    getItems() async {

      _itemList.addAll(boxItemLists.values.map((e) => PopupMenuItem<String>(value: e.id , child: createElementTile(e.name, e.id, e.price),)).toList());
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
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(minWidth: 500, maxWidth: 550,maxHeight: 275),
      context: context,
      position: position,
      items: _itemList
    );


  }
}
