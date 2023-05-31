import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';
import 'package:flutterfrontend/home/view/pages/cart/cart_items.dart';

import 'package:flutterfrontend/home/view/pages/shop/operators/product_summary_dto.dart';
import 'package:flutterfrontend/main.dart';
import 'package:provider/provider.dart';

import '../../../../constats.dart';
import 'package:flutterfrontend/boxes.dart';

import '../cart/list_item.dart';


class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const maxFontSizeHeadline = 30.0;
    const maxFontSizeText = 20.0;
    int screenHight = MediaQuery.of(context).size.height as int;

    var numberOfItemsInCart = boxItemLists.length;

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
                              leading: CachedNetworkImage(
                                imageUrl: '$apiPathPicture${listItem.id}/image1',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                height: 50,
                                width: 50,
                                fit: BoxFit.fitHeight,),
                              title: Text(listItem.name),

                              subtitle: Text(listItem.description),
                              trailing: Text(listItem.price + '€'),

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
                              Text("1.00 €",
                            textAlign: TextAlign.right,)
                          ),
                          SizedBox(width: 15),
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
