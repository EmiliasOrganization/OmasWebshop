
import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/globalwidget/login_registration_button.dart';
import 'package:flutterfrontend/globalwidget/shoppingcart_popup_menu.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../boxes.dart';
import '../home/view/pages/cart/cart_items.dart';


class TopBarFirst extends StatefulWidget implements PreferredSizeWidget {
  final ItemScrollController? itemScrollController;
  final bool ueberUns;
  final int? itemCount;

  const TopBarFirst({
    Key? key,
    required this.ueberUns,
    this.itemScrollController,
    this.itemCount,
  }) : super(key: key);

  @override
  State<TopBarFirst> createState() => _TopBarFirstState();

 @override
  Size get preferredSize => Size.fromHeight(78);
}


class _TopBarFirstState extends State<TopBarFirst> {

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
    return  AppBar(
      toolbarHeight: 78,
      automaticallyImplyLeading: false,
      title: Image.asset(
        'ArtisManusLogoKlein.png',
        fit: BoxFit.fitHeight),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4),
        child: Container(
          color: schemeColorGreen,
          height: 1,
        ),
      ),
      backgroundColor: schemeColorMistyRose,
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
        SizedBox(width: 20),
        Column(
          children: [
            ShoppingCartButton(),
            Text("Warenkorb")
          ],
        ),
        // CountButtonWithPopup(),
        SizedBox(width: 20),
        Column(
          children: [
            LoginButton(),
            Text("Profil")
          ],
        ),
        SizedBox(width: 20),
        Column(
          children: [
            IconButton(
                icon: Icon(
                    Icons.mail,
                    color: schemeColorGreen
                ), onPressed: () {}
            ),
            Text("Kontakt")
          ],
        ),
        SizedBox(width: 20)
      ],
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