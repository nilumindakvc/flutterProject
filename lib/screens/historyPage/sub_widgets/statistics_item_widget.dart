import 'package:flutter/material.dart';
import 'package:vpn/theme/app_colors.dart';

class StatisticsItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatisticsItemWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.luminousGreen, size: 20),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
