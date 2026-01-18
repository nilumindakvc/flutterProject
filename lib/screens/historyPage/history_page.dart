import 'package:flutter/material.dart';
import 'package:vpn/models/connection_history.dart';
import 'package:vpn/screens/historyPage/sub_widgets/history_widget.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/theme/app_text_styles.dart';
import 'package:vpn/widgets/back_arrow_widget.dart';
import 'package:vpn/widgets/bin_widget.dart';
import 'sub_widgets/statistics_summary_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
    required this.connectionHistory,
    required this.historyClere,
  });

  final List<ConnectionHistory> connectionHistory;
  final VoidCallback historyClere;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    const darkBackground = Color(0xFF000000);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.darkGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BackArrowWidget(onPress: () => Navigator.pop(context)),
                        SizedBox(width: 16),
                        Text(
                          'Connection History',
                          style: AppTextStyles.appBarHeading,
                        ),
                      ],
                    ),
                    BinWidget(
                      callback: () {
                        _showClearHistoryDialog(widget.historyClere);
                      },
                    ),
                  ],
                ),
              ),

              // Statistics Summary
              StatisticsSummaryWidget(
                connectionHistory: widget.connectionHistory,
              ),

              SizedBox(height: 24),

              // History List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: widget.connectionHistory.length,
                  itemBuilder: (context, index) {
                    final session = widget.connectionHistory[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: HistoryWidget(object: session),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearHistoryDialog(VoidCallback clearer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1A1A1A),
          title: Text('Clear History', style: TextStyle(color: Colors.white)),
          content: Text(
            'Are you sure you want to clear all connection history?',
            style: TextStyle(color: Colors.white.withOpacity(0.8)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.historyClere();
                });

                Navigator.pop(context);
              },
              child: Text('Clear', style: TextStyle(color: Color(0xFFFF4444))),
            ),
          ],
        );
      },
    );
  }
}
