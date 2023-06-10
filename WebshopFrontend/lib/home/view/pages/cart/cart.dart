import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/boxes.dart';
import 'package:flutterfrontend/home/view/pages/cart/list_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../boxes.dart';
import '../../../../boxes.dart';
import '../../../../constats.dart';
import 'cart_items.dart';
import 'package:hive/hive.dart';

class RoundetTextPictureProperties {
  final double pictureSizeWidth;
  final double pictureSizeHeight;
  final String picture;
  final String headLineText;
  final String routePath;

  const RoundetTextPictureProperties({
    required this.pictureSizeWidth,
    required this.pictureSizeHeight,
    required this.picture,
    required this.headLineText,
    required this.routePath,
  });
}

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text("Hello World");
  }
}

class HoverCart extends StatefulWidget {
  const HoverCart({Key? key}) : super(key: key);

  @override
  State<HoverCart> createState() => _HoverCartState();
}

class _HoverCartState extends State<HoverCart> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: boxItemLists.length,
        itemBuilder: (context, index){
          ListItem listItem = boxItemLists.getAt(index);
          // ListItem item = cartProvider.boxItemLists.getAt(index);
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
      );
  }
}
