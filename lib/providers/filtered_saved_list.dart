import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class FilterSavedList with ChangeNotifier {
  List<Product> _FilterSavedList = [];
  List<Product> get currentList {
    return [..._FilterSavedList];
  }

  void saveProduct(Product product) {
    _FilterSavedList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _FilterSavedList.remove(product);
    notifyListeners();
  }
}
