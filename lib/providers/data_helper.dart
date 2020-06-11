import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import '../models/product.dart';

Future<Product> fetchProduct(String searchKey) async {
  Map<String, String> queryParameters = {
    'query': searchKey,
  };
  var uri = Uri.https(
    'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
    '/food/products/search',
    queryParameters,
  );
  final response = await http.get(
    uri,
    headers: {
      'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
      'X-RapidAPI-Key': '8955002e2dmsh32a65a55912f68bp12b80cjsnc1a962733782',
    },
  );
  if (response.statusCode == 200)
    print('Connected');
  else
    throw Exception('Connection failed');
  // print(json.decode(response.body));
  Map<String, dynamic> hold = jsonDecode(response.body);
  List products = hold['products'];
  print(products.elementAt(0));
  // print('${hold['type']}');
}