import 'package:flutter/material.dart';
import '../../../../globalwidget/differnt_picture_row.dart';
import '../../../../globalwidget/roundet_text_picture.dart';

class FirstShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final topRowPosition = screenHeight * 0.08;
    final bottomRowPosition = topRowPosition + 350;

    const pictureSizeWidth = 300.0;
    const pictureSizeHeight = 300.0;

    final List<RoundetTextPictureProperties> roundetTextPicturePropertiesList = [
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Taschen',
      ),
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Kopfbedeckungen',
      ),
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Kinder',
      ),
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Socken',
      ),
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Kuscheltiere',
      ),
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Handschuhe',
      ),
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Kissen & Decken',
      ),
      RoundetTextPictureProperties(
        pictureSizeHeight: pictureSizeHeight,
        pictureSizeWidth: pictureSizeWidth,
        picture: '../assets/StartScreen.png',
        routePath: '/shop',
        headLineText: 'Rucksäcke',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          childAspectRatio: 1 / 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: roundetTextPicturePropertiesList.length,
        itemBuilder: (BuildContext context, int index) {
          return RoundetTextPicture(
            properties: roundetTextPicturePropertiesList[index],
          );
        }
      ),
    );
  }
}





