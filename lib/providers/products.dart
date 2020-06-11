import 'package:flutter/cupertino.dart';

import '../models/product.dart';

// Mock products
class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      barCode: '1',
      name: 'Hamburger',
      description: 'Hamburger',
      photoURL:
          'https://www.foodiesfeed.com/wp-content/uploads/2016/08/tiny-pickles-on-top-of-burger-1-413x275.jpg',
      qrCode: '1',
      type: 'Food',
      tags: ['Obesity', 'High Blood Pressure'],
      illnesss: Illness(
        obesity: true,
        highBloodPressure: true,
        headache: false,
        stomache: false,
        covid19: false,
      ),
    ),
    Product(
      barCode: '1',
      name: 'Hamburger',
      description: 'Hamburger',
      photoURL:
          'https://www.foodiesfeed.com/wp-content/uploads/2016/08/tiny-pickles-on-top-of-burger-1-413x275.jpg',
      qrCode: '1',
      type: 'Food',
      tags: ['Obesity', 'High Blood Pressure'],
      illnesss: Illness(
        obesity: true,
        highBloodPressure: true,
        headache: false,
        stomache: false,
        covid19: false,
      ),
    ),
  ];
  List<Product> get products {
    return [..._products];
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct() {
    if (_products.length == 0) return;
    _products.removeLast();
    notifyListeners();
  }

  void doFilter(UserInput userInput,Product product) {
    //Check the health's setting of user
    if ( UserInput._healthInput[0].obesity == product.illnesss.obesity){
      product.isHealthy = false;
    }
    print(product.isHealthy);
    notifyListeners();
  }
   void updateProductHealthValid(Product product,bool value){
    product.isHealthy = value;
    notifyListeners();
  }
}

// Mock user input for health's setting
class UserInput with ChangeNotifier {
  static List<Illness> _healthInput = [
    Illness(
      obesity: false,
      highBloodPressure: false,
      headache: false,
      stomache: false,
      covid19: false,
    )
  ];
  List<Illness> get healthInput {
    return [..._healthInput];
  }

  List<String> _illness = [
    'Obesity',
    'High Blood Pressure',
    'Headache',
    'Stomache',
    'Covid19'
  ];
  List<String> get illness {
    return [..._illness];
  }

  void updateInput(String illness, bool value, int page) {
    page = 0;
    switch (illness) {
      case 'Obesity':
        {
          _healthInput[page].obesity = value;
        }
        break;
      case 'High Blood Pressure':
        {
          _healthInput[page].highBloodPressure = value;
        }
        break;
      case 'Headache':
        {
          _healthInput[page].headache = value;
        }
        break;
      case 'Stomache':
        {
          _healthInput[page].stomache = value;
        }
        break;
      case 'Covid19':
        {
          _healthInput[page].covid19 = value;
        }
        break;
      default:
        {
          print('Error');
          break;
        }
    }
    notifyListeners();
  }
}
