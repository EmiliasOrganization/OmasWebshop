import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget{
  const TopBar({Key? key, required this.itemScrollController, required this.ueberUns}) : super(key: key);

  final ItemScrollController itemScrollController;
  final ueberUns;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(
            color: schemeColorGreen,
            height: 2,
          ),
        ),
        backgroundColor: schemeColorOrange,
        // backgroundColor: Colors.amber,
        actions: [
          if(ueberUns)
          ElevatedButton(
            child: (Text('Über uns')),
            onPressed: () {
              itemScrollController.scrollTo(
                  index: 2, duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
          ),
          SizedBox(width: 8),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){}
          ),
          SizedBox(width: 8),
          IconButton(
              icon: Icon(Icons.person),
            onPressed: (){},
          ),
          SizedBox(width: 8),
          IconButton(icon: Icon(Icons.mail), onPressed: () {}
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}