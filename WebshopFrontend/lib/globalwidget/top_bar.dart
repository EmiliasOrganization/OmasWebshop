import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../home/view/pages/cart/cart_items.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget{
  final ItemScrollController? itemScrollController;
  final bool ueberUns;
  final String? title;
  final int? itemCount;
  const TopBar({Key? key, this.itemScrollController, required this.ueberUns, this.title, this.itemCount}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> {
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
          Consumer<CartProvider>( // Wrap the widget in Consumer
                      builder: (context, cartProvider, _) {
                        CartProvider cartProvider = Provider.of<CartProvider>(context);
                        List<CartElement> cartItems = cartProvider.cartItems;
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          MouseRegion(
                            onEnter: (event) {
                              setState(() {
                                hoverstate = true;
                              });
                              showCartPopup(context);
                            },
                            onExit: (event) {
                              setState(() {
                                hoverstate = false;
                              });
                              hideCartPopup();
                            },
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart, color: hoverstate ? schemeColorMistyRose: schemeColorGreen),
                              onPressed: (){},
                            ),
                          ),
                              if (cartProvider.itemCount > 0) // Use productCount from the cartItems list
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                              cartProvider.itemCount.toString(),
                                style: TextStyle(
                                  color: schemeColorGreen,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                        ],
                      );
                    }
                  ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(
                Icons.person,
                color: schemeColorGreen),
            onPressed: (){},
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
  void showCartPopup(BuildContext context) {
    final RenderBox appBarRenderBox = context.findRenderObject() as RenderBox;
    final Offset appBarOffset = appBarRenderBox.localToGlobal(Offset.zero); // Adjust the height according to your needs

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: appBarOffset.dy + kToolbarHeight + 10,
          left: appBarOffset.dx - 300,
          width: MediaQuery.of(context).size.width * 0.25,
          height: 200,
          child: Material(
            elevation: 4,
            child: SmallShoppingSummary(),
          ),
        );
      },
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void hideCartPopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    hideCartPopup(); // Make sure to remove the popup overlay when the widget is disposed
    super.dispose();
  }
}

class SmallShoppingSummary extends StatefulWidget {
  const SmallShoppingSummary({Key? key}) : super(key: key);

  @override
  State<SmallShoppingSummary> createState() => _SmallShoppingSummaryState();
}

class _SmallShoppingSummaryState extends State<SmallShoppingSummary> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return ListView.builder(
        itemCount: cartProvider.itemCount,
        // Replace with the actual number of images
        itemBuilder: (context, index) {
          CartElement item = cartProvider.cartItems[index];
          return ListTile(
            leading: Image.asset(
              '../assets/StartScreen.png',
              width: 50,
              height: 50,
            ),
            title: Text(item.productName),
            subtitle: Text(item.productId),
          );
        });
    }
}

