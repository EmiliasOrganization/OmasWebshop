

import 'package:flutter/material.dart';
import '../../../../globalwidget/roundet_text_picture.dart';

class FirstShopScreen extends StatelessWidget {



  //TODO: Refactor Button in one Widget
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final topRowPosition = screenHeight * 0.08;
    final bottomRowPosition = topRowPosition + 350;

    return Stack(
      children: [
        FourPictureRow(
          topPosition: topRowPosition,
          pictureSizeHeight: 300,
          pictureSizeWidth: 300,
          picture1: '../assets/StartScreen.png',
          headLineText1: 'Shop 1',
          picture2: '../assets/StartScreen.png',
          headLineText2: 'Shop 2',
          picture3: '../assets/StartScreen.png',
          headLineText3: 'Shop 3',
          picture4: '../assets/StartScreen.png',
          headLineText4: 'Shop 4',
        ),
        FourPictureRow(
          topPosition: bottomRowPosition,
          pictureSizeHeight: 300,
          pictureSizeWidth: 300,
          picture1: '../assets/StartScreen.png',
          headLineText1: 'Shop 5',
          picture2: '../assets/StartScreen.png',
          headLineText2: 'Shop 6',
          picture3: '../assets/StartScreen.png',
          headLineText3: 'Shop 7',
          picture4: '../assets/StartScreen.png',
          headLineText4: 'Shop 8',
        ),
      ],
    );
  }
}

class FourPictureRow extends StatelessWidget {
  const FourPictureRow({
    super.key,
    required this.topPosition,
    required this.pictureSizeWidth,
    required this.pictureSizeHeight,
    required this.picture1,
    required this.picture2,
    required this.picture3,
    required this.picture4,
    required this.headLineText1,
    required this.headLineText2,
    required this.headLineText3,
    required this.headLineText4
  });

  final topPosition;
  final pictureSizeWidth;
  final pictureSizeHeight;
  final picture1;
  final picture2;
  final picture3;
  final picture4;
  final headLineText1;
  final headLineText2;
  final headLineText3;
  final headLineText4;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundetTextPicture(pictureSizeWidth: pictureSizeWidth, pictureSizeHeight: pictureSizeHeight, picture: picture1, headLineText: headLineText1),
          SizedBox(width: 20),
          RoundetTextPicture(pictureSizeWidth: pictureSizeWidth, pictureSizeHeight: pictureSizeHeight, picture: picture2, headLineText: headLineText2),
          SizedBox(width: 20),
          RoundetTextPicture(pictureSizeWidth: pictureSizeWidth, pictureSizeHeight: pictureSizeHeight, picture: picture3, headLineText: headLineText3),
          SizedBox(width: 20),
          RoundetTextPicture(pictureSizeWidth: pictureSizeWidth, pictureSizeHeight: pictureSizeHeight, picture: picture4, headLineText: headLineText4),
        ],
      ),
    );
  }
}



