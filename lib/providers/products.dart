import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import 'user_health_data.dart';

// Mock products
class Products with ChangeNotifier {
  List<Product> _filteringProducts = [];
  List<Product> get filteringProducts {
    return [..._filteringProducts];
  }

  void addFilteringProduct(Product product) {
    _filteringProducts.add(product);
    notifyListeners();
  }

  void removeFilteringProduct(Product product) {
    _filteringProducts.remove(product);
    notifyListeners();
  }

  List<Product> _products = [];
  List<Product> _displayProducts = [];
  Map<String, bool> map = {
    'Vegan': false,
    'DairyFree': false,
    'LowFodMap': false,
    'cheap': false
  };
  List<Product> get displayProducts {
    return [..._displayProducts];
  }

  bool displayProductIsEmpty() {
    return _displayProducts.isEmpty;
  }

  void updateDisplayProduct(String key) {
    bool isValid = true;
    map.forEach((key, value) {
      if (value == true) {
        isValid = false;
      }
    });
    if (isValid == true) {
      _displayProducts.clear();
      _displayProducts.addAll(_products);
    } else {
      if (_displayProducts.length == _products.length) {
        _displayProducts.clear();
      }
      switch (key) {
        case 'Vegan':
          print('vega called again');
          print('Product: ${_products.length}');
          if (map['Vegan'] == true) {
            _displayProducts.addAll(
                _products.where((element) => element.vegetarian).toList());
            print(_displayProducts.length);
          } else
            _displayProducts.removeWhere((element) =>
                element.vegetarian &&
                !element.dairyFree &&
                !element.lowFodmap &&
                !element.cheap);
          break;
        case 'DairyFree':
          if (map['DairyFree'] == true) {
            _displayProducts.addAll(
                _products.where((element) => element.dairyFree).toList());
          } else
            _displayProducts.removeWhere((element) =>
                element.dairyFree &&
                !element.vegetarian &&
                !element.lowFodmap &&
                !element.cheap);
          break;
        case 'LowFodMap':
          if (map['LowFodMap'] == true) {
            _displayProducts.addAll(
                _products.where((element) => element.lowFodmap).toList());
          } else
            _displayProducts.removeWhere((element) =>
                element.lowFodmap &&
                !element.dairyFree &&
                !element.vegetarian &&
                !element.cheap);
          break;
        case 'cheap':
          if (map['cheap'] == true) {
            _displayProducts
                .addAll(_products.where((element) => element.cheap).toList());
          } else
            _displayProducts.removeWhere((element) =>
                element.cheap &&
                !element.dairyFree &&
                !element.lowFodmap &&
                !element.vegetarian);
          break;
      }
    }
    _displayProducts = _displayProducts.toSet().toList();
    print(_displayProducts.length);
    notifyListeners();
  }

  List<Product> get products {
    return [..._products];
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void clearProduct() {
    _products.clear();
    _displayProducts.clear();
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_products.length == 0) return;
    _products.remove(product);
    notifyListeners();
  }

  void doFilter(UserHealthData userInput, Product product) {
    //Check the health's setting of user
    if (userInput.healthInput[0].obesity) {
      if (!product.illness.obesity) {
        product.isHealthy = false;
        return;
      }
    }
    if (userInput.healthInput[0].highBloodPressure) {
      if (!product.illness.highBloodPressure) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].headache) {
      if (!product.illness.headache) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].stomache) {
      if (!product.illness.stomache) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].celiac) {
      if (!product.illness.celiac) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].digestion) {
      if (!product.illness.digestion) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].glutenSensitivity) {
      if (!product.illness.glutenSensitivity) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].heartDisease) {
      if (!product.illness.heartDisease) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].peripheralVascular) {
      if (!product.illness.peripheralVascular) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
    if (userInput.healthInput[0].stroke) {
      if (!product.illness.stroke) {
        product.isHealthy = false;
        notifyListeners();
        return;
      }
    }
  }

  void updateProductHealthValidation(Product product, bool value) {
    product.isHealthy = value;
    notifyListeners();
  }
}
