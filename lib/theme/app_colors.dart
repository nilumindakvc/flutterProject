import 'package:flutter/material.dart';

class AppColors {
  static const luminousGreen = Color(0xFF00FF88);
  static const darkBackground = Color(0xFF000000);
  static const superRed = Color.fromARGB(255, 255, 0, 0);

  // Gradient example
  static const List<Color> blueGradient = [
    Color.fromARGB(255, 167, 224, 240),
    Color.fromARGB(255, 22, 120, 148),
    Color.fromARGB(255, 9, 33, 55),
    Color.fromARGB(255, 3, 22, 40),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF000000),
    Color(0xFF0A0A0A),
    Color(0xFF111111),
  ];

  static const List<Color> yelowGradient = [
    Color.fromARGB(255, 33, 33, 1),
    Color.fromARGB(255, 55, 55, 2),
    Color.fromARGB(255, 100, 117, 4),
    Color.fromARGB(255, 180, 207, 5),
  ];
}
