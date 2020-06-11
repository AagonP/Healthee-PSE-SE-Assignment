import 'package:flutter/material.dart';

class Product {
  final String type;
  final String name;
  final String description;
  final String photoURL;
  final String barCode;
  final String qrCode;
  final List<String> tags;
  final Illness illnesss;
  bool isHealthy = true;
  Product(
      {@required this.barCode,
      @required this.description,
      @required this.name,
      @required this.photoURL,
      @required this.qrCode,
      @required this.type,
      @required this.tags,
      @required this.illnesss});
}

class Illness {
  bool obesity;
  bool highBloodPressure;
  bool stomache;
  bool headache;
  bool covid19;
  Illness({
    @required this.headache,
    @required this.obesity,
    @required this.stomache,
    @required this.highBloodPressure,
    @required this.covid19,
  });
}
