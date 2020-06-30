import 'package:flutter/cupertino.dart';

import '../models/product.dart';
import './user_input.dart';

// Mock products
class Products with ChangeNotifier {
  List<Product> _selectedProducts = [];
  List<Product> get selectedProducts {
    return [..._selectedProducts];
  }

  void addSelectedProducts(Product product) {
    _selectedProducts.add(product);
    notifyListeners();
  }
  void removeSelectedProducts(Product product) {
    _selectedProducts.remove(product);
    notifyListeners();
  }

  List<Product> _products = [];
  List<Product> get products {
    return [..._products];
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void clearProduct() {
    _products.clear();
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_products.length == 0) return;
    _products.remove(product);
    notifyListeners();
  }

  void doFilter(UserInput userInput, Product product) {
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

  void updateProductHealthValid(Product product, bool value) {
    product.isHealthy = value;
    notifyListeners();
  }
}
