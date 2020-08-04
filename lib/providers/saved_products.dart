import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class SavedProducts with ChangeNotifier {
  List<Product> _savedProducts = [];
  List<Product> get savedProducts {
    return [..._savedProducts.toSet().toList()];
  }

  void saveProduct(Product product) {
    _savedProducts.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _savedProducts.remove(product);
    notifyListeners();
  }
}
