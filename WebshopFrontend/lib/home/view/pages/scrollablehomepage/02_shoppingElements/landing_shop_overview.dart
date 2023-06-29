import 'package:flutter/material.dart';
import '../../../../../constats.dart';
import '../../../../../globalwidget/roundet_text_picture.dart';

class FirstShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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
const pictureSizeWidth = 300.0;
const pictureSizeHeight = 300.0;
final List<RoundetTextPictureProperties> roundetTextPicturePropertiesList = [
  RoundetTextPictureProperties(
    pictureSizeHeight: pictureSizeHeight,
    pictureSizeWidth: pictureSizeWidth,
    picture: 'assets/shopElements/Bags.png',
    routePath: '/shop',
    headLineText: 'Taschen',
    category: Category.BAGS,
  ),
  RoundetTextPictureProperties(
    pictureSizeHeight: pictureSizeHeight,
    pictureSizeWidth: pictureSizeWidth,
    picture: 'assets/shopElements/Hats.png',
    routePath: '/shop',
    headLineText: 'Kopfbedeckungen',
    category: Category.HATS,
  ),
  RoundetTextPictureProperties(
      pictureSizeHeight: pictureSizeHeight,
      pictureSizeWidth: pictureSizeWidth,
      picture: 'assets/shopElements/kids.png',
      routePath: '/shop',
      headLineText: 'Kinder',
      category: Category.CHILDREN
  ),
  RoundetTextPictureProperties(
    pictureSizeHeight: pictureSizeHeight,
    pictureSizeWidth: pictureSizeWidth,
    picture: 'assets/shopElements/socks.png',
    routePath: '/shop',
    headLineText: 'Socken',
    category: Category.SOCKS,
  ),
  RoundetTextPictureProperties(
    pictureSizeHeight: pictureSizeHeight,
    pictureSizeWidth: pictureSizeWidth,
    picture: 'assets/shopElements/cuddlytoy.png',
    routePath: '/shop',
    headLineText: 'Kuscheltiere',
    category: Category.CUDDLY_TOYS,
  ),
  RoundetTextPictureProperties(
      pictureSizeHeight: pictureSizeHeight,
      pictureSizeWidth: pictureSizeWidth,
      picture: 'assets/shopElements/gloves.png',
      routePath: '/shop',
      headLineText: 'Handschuhe',
      category: Category.GLOVES
  ),
  RoundetTextPictureProperties(
    pictureSizeHeight: pictureSizeHeight,
    pictureSizeWidth: pictureSizeWidth,
    picture: 'assets/shopElements/pillow.png',
    routePath: '/shop',
    headLineText: 'Kissen & Decken',
    category: Category.CUSHIONS,
  ),
  RoundetTextPictureProperties(
      pictureSizeHeight: pictureSizeHeight,
      pictureSizeWidth: pictureSizeWidth,
      picture: 'assets/shopElements/bagpack.png',
      routePath: '/shop',
      headLineText: 'Rucksäcke',
      category: Category.BACKPACKS
  ),
];




