import 'package:flutter/material.dart';
import 'cloth.dart';

class cart with ChangeNotifier {
  List<Cloth> _items = [];
  double totalprice = 0;
  void add(Cloth cloth) {
    _items.add(cloth);
    var price = double.parse(cloth.price);

    totalprice += price;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get price {
    return totalprice;
  }

  List<Cloth> get basketitem {
    return _items;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.contains(productId)) {
      return;
    }
  }
}
