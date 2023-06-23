import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'pages/scrollablehomepage/01_landingscreen/landing_screen.dart';
import 'pages/scrollablehomepage/02_shoppingElements/landing_shop_overview.dart';
import 'pages/scrollablehomepage/03_aboutus/about_us.dart';

class ContentsWidget extends StatelessWidget {

  final ItemScrollController itemScrollController;
  final String? contentElement;
  const ContentsWidget(this.contentElement, {Key? key, required this.itemScrollController}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints)
          {
            switch(contentElement)
            {
              case 'LandingPage': return  LandingScreen(itemScrollController: itemScrollController);
              case 'Shop': return FirstShopScreen();
              case 'AboutUs': return ManuallyControlledSlider();
              default: return Container();
            }
          }),
    );
  }
}