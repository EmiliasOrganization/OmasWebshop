import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/home/view/pages/cart/cart_items.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/vitality.dart';

import '../../../../constats.dart';
import '../../../../globalwidget/centered_view.dart';
import '../../content_widget.dart';
import '../../../../globalwidget/top_bar.dart';

class HomePage extends StatefulWidget {

  final scrollController = ScrollController();

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context)  =>

      CenteredView(
        child: Scaffold(
          appBar: TopBar(itemScrollController: itemScrollController, ueberUns: true ),
          body: Stack(children: [
            Vitality.randomly(
              background: schemeColorMistyRose,
              height: 1080 *3,
              width: 1920,
              itemsCount: 15,
              enableXMovements: false,
              enableYMovements: false,
              minSize: 80,
              maxSize: 120,
              randomItemsBehaviours: [
                ItemBehaviour(shape: ShapeType.FilledCircle)
              ], randomItemsColors: [
              Colors.grey,
            ],
            ),
            ScrollablePositionedList.builder(
                minCacheExtent: 0,
                itemCount: 3,
                itemScrollController: itemScrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ContentsWidget(contentElements[index], itemScrollController: itemScrollController);
                }),
          ]),
        ),
      );
}