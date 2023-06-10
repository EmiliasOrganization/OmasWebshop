import 'package:flutter/cupertino.dart';
import 'package:flutterfrontend/boxes.dart';

class CartProvider extends ChangeNotifier {
  int _itemCount = boxItemLists.length;

  int get itemCount => _itemCount;

  void updateItemCount() {
    _itemCount = boxItemLists.length;
    notifyListeners();
  }

}