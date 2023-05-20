
import 'package:flutter/material.dart';
import 'package:flutterfrontend/home/view/pages/shop/shop_screen.dart';
import 'package:flutterfrontend/home/view/pages/shoppingcart/shoppingcart.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'home/view/pages/cart/cart.dart';
import 'home/view/pages/cart/cart_items.dart';
import 'home/view/pages/checkout/checkout.dart';
import 'home/view/pages/homepage/homepage.dart';
import 'constats.dart';
import 'home/view/pages/login/login.dart';
import 'home/view/pages/produkt/product_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
    ],
    child: WebShop(),
  ),
  );
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
        '/shop': (context) => OnlyShopScreen(),
        '/cart': (context) => Cart(),
        '/login': (context) => Login(),
        '/checkout': (context) => Checkout(),
        '/shoppingCart': (context) => ShoppingCart(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.startsWith('/product/')) {
          final productId = settings.name!.split('/').last;
          return MaterialPageRoute(
            builder: (context) => ProductPage(productId: productId),
          );
        }
        return null;
      },
    );
  }
}








