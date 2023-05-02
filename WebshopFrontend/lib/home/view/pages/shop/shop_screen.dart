import 'package:flutter/material.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';
import 'package:flutterfrontend/home/view/pages/shop/shopping_screen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class OnlyShopScreen extends StatelessWidget {

   ItemScrollController itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    return CenteredView(
      child: Scaffold(
        appBar: TopBar(itemScrollController: itemScrollController, ueberUns: false, title: 'Oma\'s Webshop',),
        body: Container(
          child: ProductListScreen(),
        ),
      ),
    );
  }
}