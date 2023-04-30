import 'package:flutter/material.dart';
import '../../../../globalwidget/differnt_picture_row.dart';

class FirstShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final topRowPosition = screenHeight * 0.08;
    final bottomRowPosition = topRowPosition + 350;

    return Stack(
      children: [
        FourPictureRowClickable(
          topPosition: topRowPosition,
          pictureSizeHeight: 300,
          pictureSizeWidth: 300,
          picture1: '../assets/StartScreen.png',
          routePath1: '/shop',
          headLineText1: 'Taschen',
          picture2: '../assets/StartScreen.png',
          routePath2: '/shop',
          headLineText2: 'Kopfbedeckungen',
          picture3: '../assets/StartScreen.png',
          routePath3: '/shop',
          headLineText3: 'Kinder',
          routePath4: '/shop',
          picture4: '../assets/StartScreen.png',
          headLineText4: 'Socken',
        ),
        FourPictureRowClickable(
          topPosition: bottomRowPosition,
          pictureSizeHeight: 300,
          pictureSizeWidth: 300,
          picture1: '../assets/StartScreen.png',
          headLineText1: 'Kuscheltiere',
          routePath1: '/shop',
          picture2: '../assets/StartScreen.png',
          headLineText2: 'Handschuhe',
          routePath2: '/shop',
          picture3: '../assets/StartScreen.png',
          headLineText3: 'Kissen & Decken',
          routePath3: '/shop',
          picture4: '../assets/StartScreen.png',
          headLineText4: 'Rucksäcke',
          routePath4: '/shop',
        ),
      ],
    );
  }
}





