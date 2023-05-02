import 'package:flutter/material.dart';

import '../../../../constats.dart';

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

// if (product.description != null)
// Text(product.description!),