
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/vitality.dart';

import 'globalwidget/centered_view.dart';
import 'home/view/pages/landingscreen/top_bar.dart';
import 'home/widget/content_widget.dart';
import 'constats.dart';

void main() {
  runApp(WebShop());
}
class WebShop extends StatelessWidget {
  const WebShop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return MaterialApp(
        title: 'Oma\'s Webshop',
        color: Colors.orange,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: HomePage(),
    );
  }
}

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
          appBar: TopBar(itemScrollController: itemScrollController ),
          body: Stack(children: [
            Vitality.randomly(
              background: Color(0xFFF6DEE0),
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
            // NavigationMenu(itemScrollController)
          ]),
        ),
      );
}




