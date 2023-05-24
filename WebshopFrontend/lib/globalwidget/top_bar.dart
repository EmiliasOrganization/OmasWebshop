import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfrontend/boxes.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/home/view/pages/cart/list_item.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../home/view/pages/cart/cart.dart';
import '../home/view/pages/cart/cart_items.dart';


class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final ItemScrollController? itemScrollController;
  final bool ueberUns;
  final String? title;
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

  Timer? _popupTimer;
  final Duration _popupHideDuration = Duration(seconds: 1);

  bool popUpVisible = false;
  bool hoverstate = false;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: widget.title != null ? Text(widget.title!) : null,
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
          //noch abändern
          Consumer<CartProvider>( // Wrap the widget in Consumer
            builder: (context, cartProvider, _) {
              GlobalKey _mouseRegionKey = GlobalKey();
              CartProvider cartProvider = Provider.of<CartProvider>(context);
              List<CartElement> cartItems = cartProvider.cartItems;
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Builder(
                    builder: (context) => MouseRegion(
                      key: _mouseRegionKey,
                      onEnter: (event) {
                        setState(() {
                          hoverstate = true;
                        });
                        if (!popUpVisible) {
                          showCartPopup(context, cartItems);
                        }
                      },
                      onExit: (event) {
                        _popupTimer = Timer(_popupHideDuration, () {
                          hideCartPopup();
                        });
                        setState(() {
                          hoverstate = false;
                        });
                      },
                        child:
                        IconButton(
                          icon: Icon(Icons.shopping_cart,
                              color: schemeColorGreen,
                              // color: hoverstate ? schemeColorMistyRose : schemeColorGreen
                          ),
                          onPressed: () {
                          Navigator.pushNamed(context, '/shoppingCart');
                          },
                        ),
                    ),
                  ),

                      if (boxItemLists.length > 0) // Use productCount from the cartItems list, Positioned is about the little number above the cart


                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Text(

                      boxItemLists.length.toString(),

                        style: TextStyle(
                          color: schemeColorGreen,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              );}
            ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(
                Icons.person,
                color: schemeColorGreen),
            onPressed: (){
            },
          ),
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

  void showCartPopup(BuildContext context, List<CartElement> cartItems) {
    final RenderBox appBarRenderBox = context.findRenderObject() as RenderBox;
    final Offset appBarOffset = appBarRenderBox.localToGlobal(Offset.zero); // Adjust the height according to your needs

    const int maxVisibleItems = 3;
    const double itemHeight = 56.0;
    final double popupHeight = boxItemLists.length <= maxVisibleItems
        ? boxItemLists.length * itemHeight
        : maxVisibleItems * itemHeight;


    _overlayEntry = OverlayEntry(
      builder: (context) {
        popUpVisible = true;
        if (boxItemLists.isNotEmpty) {
          return Positioned(
          top: appBarOffset.dy + kToolbarHeight + 10,
          left: appBarOffset.dx - 300,
          width: MediaQuery.of(context).size.width * 0.25,
          height: popupHeight +20,
          child:Listener(
            onPointerCancel: (_) {
              setState(() {
                hoverstate = true;
              });
            },
            onPointerDown: (_) {
              setState(() {
                hoverstate = false;
              });
            },
            child: HoverDetector(
        onHover: (isHovered) {
        if (isHovered) {
        _popupTimer?.cancel();
        } else {
        _popupTimer = Timer(_popupHideDuration, () {
        hideCartPopup();
        });
        }
        },
        child:Material(
            elevation: 4,
            child: HoverCart(),
          ),
        )));
        }else {
          return SizedBox.shrink();
        }
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
  void hideCartPopup() {
    popUpVisible= false;
    _popupTimer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
  @override
  void dispose() {
    hideCartPopup(); // Make sure to remove the popup overlay when the widget is disposed
    super.dispose();
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



