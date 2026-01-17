import 'package:flutter/material.dart';

class OnetimePulseWidget extends StatelessWidget {
  const OnetimePulseWidget({
    super.key,
    required this.gradient,
    required this.icon,
  });

  final IconData icon;
  final List<Color> gradient;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: gradient.first.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(icon, size: 50, color: Colors.white),
          ),
        );
      },
    );
  }
}
