
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:decimal/decimal.dart';

import 'package:flutter/material.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';
import 'package:flutterfrontend/home/view/pages/cart/cart_items.dart';

import 'package:flutterfrontend/home/view/pages/shop/operators/product_summary_dto.dart';
import 'package:flutterfrontend/main.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../constats.dart';
import 'package:flutterfrontend/boxes.dart';

import '../cart/list_item.dart';


class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    const maxFontSizeHeadline = 30.0;
    const maxFontSizeText = 20.0;
    Decimal wholePrice = Decimal.parse('0');
    int screenHight = MediaQuery.of(context).size.height as int;
    int numberOfItemsInCart = boxItemLists.length;
    for (int i = 0; i < numberOfItemsInCart; i++) {
      ListItem price = boxItemLists.getAt(i);
      wholePrice = wholePrice + Decimal.parse(price.price);
    }
    return
      CenteredView(
      child: Scaffold(
        appBar: TopBar(ueberUns: false),
        body: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,

                height: screenHight*1.0,
              ),
              Container(
                width: 500,
                height: 400,

                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Warenkorb ($numberOfItemsInCart Artikel)',
                            style: TextStyle(
                              fontSize: maxFontSizeText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 500,
                      height: 350,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: boxItemLists.length,
                          itemBuilder: (context, index){
                            ListItem listItem = boxItemLists.getAt(index);
                            return ListTile(
                              trailing: IconButton(onPressed: (){
                                showDialog(context: context,
                                    useSafeArea: true,
                                    builder: (context) => AlertDialog(
                                      scrollable: true,
                                      title: Text('Löschen'),
                                      content: Text('Wollen Sie den Artikel aus dem Warenkorb entfernen?'),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          onPressed: () {
                                            cartProvider.updateItemCount();
                                            boxItemLists.deleteAt(index);
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(context, '/shoppingCart');
                                          },
                                          child: const Text(
                                            'Artikel löschen',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Abbrechen'),
                                        ),
                                      ],
                                    ));
                              }, icon: Icon(Icons.delete ,color: Colors.red)),
                              leading: CachedNetworkImage(
                                imageUrl: '$apiPathPicture${listItem.id}/image1',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                height: 50,
                                width: 50,
                                fit: BoxFit.fitHeight,),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(listItem.name),
                                  Text(listItem.price + '€')
                                ],
                              ),
                              subtitle: Text(listItem.description),
                            );
                          }
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 1000,
              ),
              Container(
                width: 400,

                height: 400,
                color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Gesamtsumme',
                              style: TextStyle(
                                fontSize: maxFontSizeText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          Text("Zwischensumme"),

                          Expanded(
                              child: Text('$wholePrice€',
                                  textAlign: TextAlign.right,),
                          ),

                          SizedBox(width: 15),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          Text("Lieferung"),
                          Expanded(
                              child: Text("0.00 €",
                                textAlign: TextAlign.right,)
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(color: schemeColorOrange,),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          Text("Gesamtsumme (inkl. Mwst.)"),
                          Expanded(
                              child:
                              Text('$wholePrice€',
                            textAlign: TextAlign.right,)
                          ),
                          SizedBox(width: 15),
                        ],

                      ),
                      SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/checkout');
                              },
                              child: Text('Zur Kasse')),
                        ],
                      )
                    ],
                  )
              ),
              SizedBox(
                width: 50,
              ),
            ],
          )
        ],),
      )
    );
  }
}
