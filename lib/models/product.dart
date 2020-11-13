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
      {this.type,
      this.name,
      this.description,
      this.photoURL,
      this.barCode,
      this.qrCode,
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
  Future<Map<String, dynamic>> toJson() async => {
        'type': this.type,
        'name': this.name,
        'description': this.description,
        'photoURL': this.photoURL,
        'barCode': this.barCode,
        'qrCode': this.qrCode,
        'illness': this.illness.toJson(),
        'vegetarian': this.vegetarian,
        'glutenFree': this.glutenFree,
        'cheap': this.cheap,
        'dairyFree': this.dairyFree,
        'popular': this.popular,
        'veryHealthy': this.veryHealthy,
        'lowFodmap': this.lowFodmap,
        'ingredients': this.ingredients,
        'amount': this.amount,
        'unit': this.unit,
      };
}
