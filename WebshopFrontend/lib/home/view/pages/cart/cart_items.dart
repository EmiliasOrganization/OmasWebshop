import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:hive/hive.dart';

class CartElement{

  final String productId;
  final String productName;

  CartElement({
    required this.productId,
    required this.productName,
  });
}

class CartProvider extends ChangeNotifier {
  static List<CartElement> _cartItems = [];

  List<CartElement> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  // void addToCart(CartElement item) {
  //   _cartItems.add(item);
  //   notifyListeners();
  // }

  void removeFromCart(CartElement item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  bool isInCart(String productId)
  {
    if(_cartItems.any((element) => element.productId == productId))
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}