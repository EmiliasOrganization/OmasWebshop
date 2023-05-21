import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';
import 'package:flutterfrontend/home/view/pages/cart/cart_items.dart';
import 'package:flutterfrontend/main.dart';
import 'package:provider/provider.dart';

import '../../../../constats.dart';


class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
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
              ),
              Container(
                width: 500,
                height: 100,
                color: Colors.red,
                child: ListView.builder(
                    itemCount: cartProvider.itemCount,
                    // Replace with the actual number of images
                    itemBuilder: (context, index) {
                      CartElement item = cartProvider.cartItems[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: '$apiPathPicture${item.productId}/image1',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          height: 50,
                          width: 50,
                          fit: BoxFit.fitHeight,),
                        title: Text(item.productName),
                        subtitle: Text(item.productId),
                      );
                    }),
              ),
              SizedBox(
                width: 50,
                height: 1000,
              ),
              Container(
                width: 400,
                height: 100,
                color: Colors.blue
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
