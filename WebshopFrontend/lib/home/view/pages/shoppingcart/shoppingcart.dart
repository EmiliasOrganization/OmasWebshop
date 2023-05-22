import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';
import 'package:flutterfrontend/home/view/pages/cart/cart_items.dart';
import 'package:flutterfrontend/main.dart';
import 'package:provider/provider.dart';
import '../../../../constats.dart';
import 'package:flutterfrontend/boxes.dart';

import '../cart/list_item.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                color: Colors.yellow,
                child: Column(
                  children: [
                    Text('Warenkorb ($numberOfItemsInCart Artikel)'),
                    Container(
                      width: 500,
                      height: 350,
                      color: Colors.red,
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
                              subtitle: Text(listItem.id),
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
                color: Colors.blue,
                  child: Column(
                    children: [
                      Text('Gesamtsumme'),
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
