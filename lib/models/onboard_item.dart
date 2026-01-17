import 'package:flutter/material.dart';

class OnboardingItem {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;

  OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });
}
