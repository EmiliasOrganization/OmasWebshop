import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget{
  const TopBar({Key? key, this.itemScrollController, required this.ueberUns, this.title}) : super(key: key);

  final ItemScrollController? itemScrollController;
  final bool ueberUns;
  final String? title;
  @override
  Widget build(BuildContext context) {
    bool isHovered = false; //Todo: Make widget stateful and use this variable to change the color of the icon
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: title != null ? Text(title!) : null,
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
              itemScrollController?.scrollTo(
                  index: 2, duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
          ),
          SizedBox(width: 8),
          MouseRegion(
            onEnter: (event) =>  isHovered = true, //Todo: Make widget stateful and use this variable to change the color of the icon
            onExit: (event) => isHovered = false, //Todo: Make widget stateful and use this variable to change the color of the icon
            child: IconButton(
                icon: Icon(Icons.shopping_cart, color: schemeColorGreen),
                onPressed: (){},
            ),

          ),
          SizedBox(width: 8),
          IconButton(
              icon: Icon(Icons.person, color: schemeColorGreen),
            onPressed: (){},
          ),
          SizedBox(width: 8),
          IconButton(icon: Icon(Icons.mail, color: schemeColorGreen), onPressed: () {}
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}