
import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/globalwidget/login_registration_button.dart';
import 'package:flutterfrontend/globalwidget/popups/count_button_with_popup.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../home/view/pages/cart/cart_items.dart';


class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final ItemScrollController? itemScrollController;
  final bool ueberUns;
  final bool? title;
  final int? itemCount;

  const TopBar({
    Key? key,
    required this.ueberUns,
    this.itemScrollController,
    this.title,
    this.itemCount,
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> {

  int itemCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CartProvider>(context);
  }


  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: widget.title == true ? Text(title) : null,
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
          if(widget.ueberUns)
            ElevatedButton(
              child: (Text('Über uns')),
              onPressed: () {
                widget.itemScrollController?.scrollTo(
                    index: 2, duration: Duration(seconds: 1), curve: Curves.easeInOut);
              },
            ),
          SizedBox(width: 8),
          CountButtonWithPopup(),

          SizedBox(width: 8),
          LoginButton(),
          SizedBox(width: 8),
          IconButton(
              icon: Icon(
                  Icons.mail,
                  color: schemeColorGreen
              ), onPressed: () {}
          ),
        ],
      ),
    );
  }
}


class HoverDetector extends StatefulWidget {
  final ValueChanged<bool> onHover;
  final Widget child;

  HoverDetector({required this.onHover, required this.child});

  @override
  _HoverDetectorState createState() => _HoverDetectorState();
}

class _HoverDetectorState extends State<HoverDetector> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
        widget.onHover(true);
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
        widget.onHover(false);
      },
      child: widget.child,
    );
  }
}



