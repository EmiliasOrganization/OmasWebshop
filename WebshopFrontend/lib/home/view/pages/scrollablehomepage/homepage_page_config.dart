
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/vitality.dart';

import '../../../../constats.dart';
import '../../../../globalwidget/centered_view.dart';
import '../../content_widget.dart';
import '../../../../globalwidget/top_bar.dart';
import '../../../../globalwidget/top_bar_first.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();

  bool _showTopBar = true;

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(_scrollListener);
  }

  void _scrollListener() {
    bool shouldShowTopBar = true;
    for (var item in itemPositionsListener.itemPositions.value) {
      if (item.index != 0 && item.itemLeadingEdge >= 0) {
        shouldShowTopBar = false;
        break;
      }
    }

    if (shouldShowTopBar != _showTopBar) {
      setState(() {
        _showTopBar = shouldShowTopBar;
      });
    }
  }

  @override
  Widget build(BuildContext context) => CenteredView(
    child: Scaffold(
      appBar: _showTopBar
          ? TopBarFirst(itemScrollController: itemScrollController, ueberUns: true)
          : TopBar(itemScrollController: itemScrollController, ueberUns: true) as PreferredSizeWidget,
      body: Stack(
        children: [
          Vitality.randomly(
            background: schemeColorMistyRose,
            height: 1080 * 3,
            width: 1920,
            itemsCount: 15,
            enableXMovements: false,
            enableYMovements: false,
            minSize: 80,
            maxSize: 120,
            randomItemsBehaviours: [
              ItemBehaviour(shape: ShapeType.FilledCircle)
            ],
            randomItemsColors: [
              Colors.grey,
            ],
          ),
          ScrollablePositionedList.builder(
            minCacheExtent: 0,
            itemCount: 3,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener, // Add this line
            itemBuilder: (BuildContext context, int index) {
              return ContentsWidget(
                contentElements[index],
                itemScrollController: itemScrollController,
              );
            },
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(_scrollListener);
    super.dispose();
  }
}