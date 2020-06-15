import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class FilterSavedList with ChangeNotifier {
  List<Product> _currentList = [];
  List<Product> get currentList {
    return [..._currentList];
  }

  void saveItem(Product product) {
    _currentList.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _currentList.remove(product);
    notifyListeners();
  }
}
