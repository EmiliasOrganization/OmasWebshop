import 'package:flutter/material.dart';
import 'package:flutterfrontend/home/view/pages/landingscreen/top_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class OnlyShopScreen extends StatelessWidget {

   ItemScrollController itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(itemScrollController: itemScrollController, ueberUns: false),
      body: Container(
        child: Text('HelloWorld!'),
      ),
    );
  }
}