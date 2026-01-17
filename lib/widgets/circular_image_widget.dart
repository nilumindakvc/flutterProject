import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  const CircularImageWidget({
    super.key,
    required this.gradient,
    required this.shadowColor,
    required this.blurRadius,
    required this.spreadRadius,
    required this.icon,
  });

  final List<Color> gradient;
  final Color shadowColor;
  final double blurRadius;
  final double spreadRadius;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: gradient),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(icon, size: 35, color: Colors.black),
    );
  }
}
