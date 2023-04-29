

import 'package:flutter/material.dart';

class FirstShopScreen extends StatelessWidget {



  //TODO: Refactor Button in one Widget
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        FourPictureRow(
          topPosition: screenHeight * 0.08,
          pictureSizeHeight: 300,
          pictureSizeWidth: 300,
          picture1: '../assets/StartScreen.png',
          picture2: '../assets/StartScreen.png',
          picture3: '../assets/StartScreen.png',
          picture4: '../assets/StartScreen.png',
        ),
        FourPictureRow(
          topPosition: screenHeight * 0.5,
          pictureSizeHeight: 300,
          pictureSizeWidth: 300,
          picture1: '../assets/StartScreen.png',
          picture2: '../assets/StartScreen.png',
          picture3: '../assets/StartScreen.png',
          picture4: '../assets/StartScreen.png',
        ),
      ],
    );
  }
}

class FourPictureRow extends StatelessWidget {
  const FourPictureRow({
    super.key, required this.topPosition, required this.pictureSizeWidth, required this.pictureSizeHeight, required this.picture1, required this.picture2,  required this.picture3, required this.picture4,
  });

  final topPosition;
  final pictureSizeWidth;
  final pictureSizeHeight;
  final picture1;
  final picture2;
  final picture3;
  final picture4;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: pictureSizeWidth,
              height: pictureSizeHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(picture1),
                    Positioned(
                      top: 1,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Button 1',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {},
            child: Container(
              width: pictureSizeWidth,
              height: pictureSizeHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(picture2),
                    Positioned(
                      top: 1,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Button 1',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {},
            child: Container(
              width: pictureSizeWidth,
              height: pictureSizeHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(picture3),
                    Positioned(
                      top: 1,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Button 1',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {},
            child: Container(
                width: pictureSizeWidth,
                height: pictureSizeHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(picture4),
                    Positioned(
                      top: 1,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Button 1',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

