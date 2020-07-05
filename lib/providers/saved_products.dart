import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class SavedProducts with ChangeNotifier {
  List<Product> _SavedProducts = [];
  List<Product> get savedProducts {
    return [..._SavedProducts];
  }

  void saveProduct(Product product) {
    _SavedProducts.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _SavedProducts.remove(product);
    notifyListeners();
  }
}
