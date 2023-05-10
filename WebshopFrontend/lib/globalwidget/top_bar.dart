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
                            onEnter: (event) => setState(() => hoverstate = true),
                            onExit: (event) => setState(() => hoverstate = false),
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
}
