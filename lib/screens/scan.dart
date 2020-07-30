import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pse_assignment/models/product.dart';

class Scan {
  static String key;
  static Future scanner() async {
    key = await FlutterBarcodeScanner.scanBarcode(
        "#009922", "Cancel", true, ScanMode.DEFAULT);
  }
}

class ScanProduct {
  final String name;
  final String calories;
  final String cholesterol;
  final String fat;
  final String image;
  final String protein;
  final String carbohydrate;
  // final List<String> ingredients;
  ScanProduct(
      {this.name,
        this.calories,
        this.cholesterol,
        this.fat,
        this.image,
        this.protein,
        this.carbohydrate
      }
      );
  Future<Map<String, dynamic>> toJson() async => {
    'name': this.name,
    'calories': this.calories,
    'image': this.image,
    'cholesterol': this.cholesterol,
    'protein': this.protein,
    'fat': this.fat,
    'carbohydrate': this.carbohydrate
  };
}

ScanProduct decodeProduct(dynamic json)
{
  String name = json["name"];
  String calories = json["calories"];
  String cholesterol = json["cholesterol"];
  String fat = json["fat"];
  String image = json["image"];
  String protein = json["protein"];
  String carbohydrate = json["carbohydrate"];
  ScanProduct product = ScanProduct(
    name: name,
    calories: calories,
    cholesterol: cholesterol,
    fat: fat,
    image: image,
    protein: protein,
    carbohydrate: carbohydrate
  );
  return product;
}
Future<DocumentSnapshot> getEntry(String key) async {
  DocumentSnapshot documentSnapshot =
  await Firestore.instance.collection('product').document(key).get();
  return documentSnapshot;
}
