import 'package:flutter/material.dart';
import 'package:vpn/models/country.dart';
import 'package:vpn/theme/app_colors.dart';

class CountryListViewerWidget extends StatefulWidget {
  const CountryListViewerWidget({
    super.key,
    required this.country,
    required this.isSelected,
    required this.callback,
  });

  final Country country;
  final bool isSelected;
  final VoidCallback callback;

  @override
  State<CountryListViewerWidget> createState() =>
      _CountryListViewerWidgetState();
}

class _CountryListViewerWidgetState extends State<CountryListViewerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected
              ? AppColors.luminousGreen.withOpacity(0.1)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.isSelected
                ? AppColors.luminousGreen
                : Colors.white.withOpacity(0.1),
            width: widget.isSelected ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.callback,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Flag
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        widget.country.flag,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),

                  SizedBox(width: 16),

                  // Country Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.country.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (widget.country.premium)
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFD700),
                                      Color(0xFFFFA500),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'PRO',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.country.city,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Server Stats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.signal_cellular_alt,
                            color: _getLoadColor(widget.country.low),
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.country.ping,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getLoadColor(
                            widget.country.low,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.country.low,
                          style: TextStyle(
                            color: _getLoadColor(widget.country.low),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 12),

                  // Selection Indicator
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.isSelected
                            ? AppColors.luminousGreen
                            : Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                      color: widget.isSelected
                          ? AppColors.luminousGreen
                          : Colors.transparent,
                    ),
                    child: widget.isSelected
                        ? Icon(Icons.check, color: Colors.black, size: 16)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getLoadColor(String load) {
    switch (load.toLowerCase()) {
      case 'low':
        return Color(0xFF00FF88);
      case 'medium':
        return Color(0xFFFFA500);
      case 'high':
        return Color(0xFFFF4444);
      default:
        return Colors.white;
    }
  }
}
