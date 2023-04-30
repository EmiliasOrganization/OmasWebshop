import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constats.dart';

class RoundetTextPicture extends StatelessWidget {
  const RoundetTextPicture({
    super.key,
    required this.pictureSizeWidth,
    required this.pictureSizeHeight,
    required this.picture,
    required this.headLineText,
  });

  final pictureSizeWidth;
  final pictureSizeHeight;
  final picture;
  final headLineText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                top: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: pictureSizeWidth -30,
                        color: schemeColorGreen,
                        child: Text(
                          headLineText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: schemeColorOrange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
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