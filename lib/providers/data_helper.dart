import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class DataHelper {
  Future<dynamic> fetchData(String url) async {
    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Host':
            'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
        'X-RapidAPI-Key': '8955002e2dmsh32a65a55912f68bp12b80cjsnc1a962733782',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else
      throw Exception('Connection failed');
  }
}
//Map<String, String> queryParameters = {
//  'query': name,
//};
//var uri = Uri.https(
//  'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
//  path,
//  queryParameters,
//);
