import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class FilterSavedList with ChangeNotifier {
  List<Product> _currentList = [];
  List<Product> get currentList {
    return [..._currentList];
  }

  void saveProduct(Product product) {
    _currentList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _currentList.remove(product);
    notifyListeners();
  }
}
