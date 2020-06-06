import 'package:flutter/material.dart';

class Product {
  final String type;
  final String name;
  final String description;
  final String photoURL;
  final String barCode;
  final String qrCode;
  final List<String> tags;
  bool isHealthy;
  Product(
      {@required this.barCode,
      @required this.description,
      @required this.name,
      @required this.photoURL,
      @required this.qrCode,
      @required this.type,
      @required this.tags});
}
