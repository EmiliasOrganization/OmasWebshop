import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/home/view/pages/shop/only_shop_screen.dart';

import '../constats.dart';

class RoundetTextPicture extends StatelessWidget {
  const RoundetTextPicture({
    super.key,
    required this.pictureSizeWidth,
    required this.pictureSizeHeight,
    required this.picture,
    required this.headLineText,
    required this.routePath,
  });

  final pictureSizeWidth;
  final pictureSizeHeight;
  final picture;
  final headLineText;
  final routePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.pushNamed(context, routePath);
      },
      child: Container(
        width: pictureSizeWidth,
        height: pictureSizeHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset( picture,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: pictureSizeWidth -30,
                        height: pictureSizeHeight -250,
                        color: schemeColorGreen,
                        child: Center(
                          child: Text(
                            headLineText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}