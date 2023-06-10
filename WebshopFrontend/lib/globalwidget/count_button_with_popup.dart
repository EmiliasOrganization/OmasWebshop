
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfrontend/boxes.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/home/view/pages/cart/cart.dart';
import 'package:flutterfrontend/home/view/pages/shoppingcart/shoppingcart.dart';

class CountButtonWithPopup extends StatefulWidget {
  final VoidCallback? onItemChanged;

  const CountButtonWithPopup({Key? key, this.onItemChanged}) : super(key: key);


  @override
  _CountButtonWithPopupState createState() => _CountButtonWithPopupState();



}

class _CountButtonWithPopupState extends State<CountButtonWithPopup> with TickerProviderStateMixin {

  bool _isHovered = false;
  List cartItems = boxItemLists.values.toList();
  OverlayEntry? _overlayEntry;
  Timer? _popupTimer;
  final Duration _popupHideDuration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CountButtonWithPopup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onItemChanged != null) {
      widget.onItemChanged!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          _isHovered = value;
          if (_isHovered) {
              showCartPopup(context, cartItems);
          } else {
            _popupTimer = Timer(_popupHideDuration, () {
              hideCartPopup();
            });
            // hideCartPopup();
          }
        });
      },
      child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: schemeColorGreen,
                  onPressed:() {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ShoppingCart()),);
                  }, // Replace with your desired onPressed function
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    boxItemLists.length.toString(), // Replace with your counter value
                    style: TextStyle(
                      color: schemeColorGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,


                    ),
                  ),
                ),
              ],
            ),



    );
  }

  void showCartPopup(BuildContext context, List cartItems) {
    final RenderBox appBarRenderBox = context.findRenderObject() as RenderBox;
    final Offset appBarOffset = appBarRenderBox.localToGlobal(Offset.zero); // Adjust the height according to your needs

    const int maxVisibleItems = 3;
    const double itemHeight = 56.0;
    final double popupHeight = boxItemLists.length <= maxVisibleItems
        ? boxItemLists.length * itemHeight
        : maxVisibleItems * itemHeight;


    _overlayEntry = OverlayEntry(
      builder: (context) {
        if (boxItemLists.isNotEmpty) {
          return Positioned(
              top: appBarOffset.dy + kToolbarHeight + 10,
              left: appBarOffset.dx - 300,
              width: MediaQuery.of(context).size.width * 0.25,
              height: popupHeight +20,
              child: HoverDetector(
                onHover: (value) {
                  if (value) {
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
                  ),
              );
        }else {
          return SizedBox.shrink();
        }
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
  void hideCartPopup() {
    _overlayEntry?.remove();
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




