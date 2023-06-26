
import 'package:flutter/material.dart';

import '../constats.dart';

class RoundetTextPictureProperties {
  final double pictureSizeWidth;
  final double pictureSizeHeight;
  final String picture;
  final String headLineText;
  final String routePath;
  final Category? category;

  const RoundetTextPictureProperties({
    required this.pictureSizeWidth,
    required this.pictureSizeHeight,
    required this.picture,
    required this.headLineText,
    required this.routePath,
    this.category,
  });
}

class RoundetTextPicture extends StatelessWidget {
  const RoundetTextPicture({
    super.key,
    required this.properties,
  });

  final RoundetTextPictureProperties properties;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.pushNamed(
            context,
            properties.routePath,
            arguments: properties.category
        );
      },
      child: SizedBox(
        width: properties.pictureSizeWidth,
        height: properties.pictureSizeHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(properties.picture,
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
                        width: properties.pictureSizeWidth -30,
                        height: properties.pictureSizeHeight -250,
                        color: schemeColorGreen,
                        child: Center(
                          child: Text(
                            properties.headLineText,
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