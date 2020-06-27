import 'package:flutter/material.dart';
import '../models/illness.dart';

class Product {
  final String type;
  final String name;
  final String description;
  final String photoURL;
  final String barCode;
  final String qrCode;
  //final List<String> tags;
  final Illness illness;
  final bool vegetarian;
  final bool glutenFree;
  final bool dairyFree;
  final bool veryHealthy;
  final bool cheap;
  final bool popular;
  final bool lowFodmap;
  final List<String> ingredients;
  final List<String> amount;
  final List<String> unit;
  bool isHealthy = true;
  Product(
      {this.barCode,
      this.description,
      this.name,
      this.photoURL,
      this.qrCode,
      this.type,
      this.illness,
      this.vegetarian,
      this.glutenFree,
      this.cheap,
      this.dairyFree,
      this.popular,
      this.veryHealthy,
      this.lowFodmap,
      this.ingredients,
      this.amount,
      this.unit});
}


