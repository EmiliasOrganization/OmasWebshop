
import 'package:flutter/material.dart';
import 'package:flutterfrontend/home/view/pages/shop/category_buttons.dart';
import 'package:flutterfrontend/home/view/pages/shop/shop_screen.dart';
import 'home/view/pages/cart/cart.dart';
import 'home/view/pages/checkout/checkout.dart';
import 'home/view/pages/homepage/homepage.dart';
import 'constats.dart';
import 'home/view/pages/login/login.dart';
import 'home/view/pages/produkt/product_page.dart';

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
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: schemeColorMistyRose),
        ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/product': (context) => ProductPage(),
        '/shop': (context) => OnlyShopScreen(),
        '/cart': (context) => Cart(),
        '/login': (context) => Login(),
        '/checkout': (context) => Checkout(),
      },
    );
  }
}








