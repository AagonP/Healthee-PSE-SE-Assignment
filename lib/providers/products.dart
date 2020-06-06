import 'package:flutter/cupertino.dart';

import '../models/product.dart';

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
      tags: ['Obesity','High Blood Pressure'],
    ),
    Product(
      barCode: '1',
      name: 'Hamburger',
      description: 'Hamburger',
      photoURL:
          'https://www.foodiesfeed.com/wp-content/uploads/2016/08/tiny-pickles-on-top-of-burger-1-413x275.jpg',
      qrCode: '1',
      type: 'Food',
      tags: ['Obesity','High Blood Pressure'],
    ),
  ];
  List<Product> get products {
    return [..._products];
  }
  void addProduct(Product product){
    _products.add(product);
    notifyListeners();
  }
  void removeProduct(){
    if (_products.length == 0 ) return;
    _products.removeLast();
    notifyListeners();
  }
  void doFilter(){
     //Check the health's setting of user
     notifyListeners();
  }
}

class UserInput with ChangeNotifier {
  List<bool> _healthInput = List<bool>.generate(5, (index) => false);
  List<bool> get healthInput {
    return [..._healthInput];
  }
  List<String> _illness = ['Obesity','High Blood Pressure','Headache','Stomache','Covid-19'];
  List<String> get illness {
    return [..._illness];
  }
  void updateInput(int counter,bool value){
    _healthInput[counter] = value;
    notifyListeners();
  }
}