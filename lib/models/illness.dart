import 'package:flutter/material.dart';

class Illness {
  bool obesity;
  bool highBloodPressure;
  bool stomache;
  bool headache;
  bool celiac;
  bool glutenSensitivity;
  bool heartDisease;
  bool digestion;
  bool peripheralVascular;
  bool stroke;
  Illness({
    @required this.headache,
    @required this.obesity,
    @required this.stomache,
    @required this.highBloodPressure,
    @required this.celiac,
    @required this.digestion,
    @required this.glutenSensitivity,
    @required this.heartDisease,
    @required this.peripheralVascular,
    @required this.stroke,
  });
}