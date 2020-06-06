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
  void addProduct(){
    notifyListeners();
  }
  void doFilter(){
     //Check the health's setting of user
  }
}