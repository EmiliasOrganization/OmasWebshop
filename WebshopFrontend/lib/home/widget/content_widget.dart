import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../view/pages/aboutus/about_us.dart';
import '../view/pages/landingscreen/landing_screen.dart';
import '../view/pages/shop/first_shopscreen.dart';


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
              case 'AboutUs': return AboutUs();
              default: return Container();
            }
          }),
    );
  }
}