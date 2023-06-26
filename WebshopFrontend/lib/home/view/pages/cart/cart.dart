
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/boxes.dart';
import 'package:flutterfrontend/home/view/pages/cart/list_item.dart';

import '../../../../constats.dart';

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
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: '$shopApi/picture/${listItem.id}/image1',
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
