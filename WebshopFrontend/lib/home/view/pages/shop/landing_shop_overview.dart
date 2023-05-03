import 'package:flutter/material.dart';
import '../../../../constats.dart';
import '../../../../globalwidget/roundet_text_picture.dart';

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





