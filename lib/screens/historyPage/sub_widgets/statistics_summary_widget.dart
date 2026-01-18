import 'package:flutter/material.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/models/connection_history.dart';
import 'statistics_item_widget.dart';

class StatisticsSummaryWidget extends StatelessWidget {
  final List<ConnectionHistory> connectionHistory;

  const StatisticsSummaryWidget({super.key, required this.connectionHistory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.yelowGradient),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.luminousGreen.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: StatisticsItemWidget(
                label: 'Total Sessions',
                value: '${connectionHistory.length}',
                icon: Icons.history,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: Colors.white.withOpacity(0.2),
            ),
            // Expanded(
            //   child: StatisticsItemWidget(
            //     label: 'Data Used',
            //     value: _calculateTotalData(),
            //     icon: Icons.data_usage,
            //   ),
            // ),
            Container(
              width: 1,
              height: 40,
              color: Colors.white.withOpacity(0.2),
            ),
            Expanded(
              child: StatisticsItemWidget(
                label: 'Success Rate',
                value: _calculateSuccessRate(),
                icon: Icons.trending_up,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // String _calculateTotalData() {
  //   double totalMB = 0;
  //   for (var session in connectionHistory) {
  //     String dataStr = session.dataUsed;
  //     if (dataStr.contains('GB')) {
  //       totalMB += double.parse(dataStr.replaceAll(' GB', '')) * 1024;
  //     } else {
  //       totalMB += double.parse(dataStr.replaceAll(' MB', ''));
  //     }
  //   }

  //   if (totalMB > 1024) {
  //     return '${(totalMB / 1024).toStringAsFixed(1)} GB';
  //   } else {
  //     return '${totalMB.toInt()} MB';
  //   }
  // }

  String _calculateSuccessRate() {
    if (connectionHistory.isEmpty) {
      return '0%';
    }

    int successful = connectionHistory
        .where((s) => s.status == 'completed')
        .length;
    double rate = (successful / connectionHistory.length) * 100;
    return '${rate.toInt()}%';
  }
}
