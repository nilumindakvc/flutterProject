import 'package:flutter/material.dart';
import 'package:vpn/models/connection_history.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key, required this.object});

  final ConnectionHistory object;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              // Flag and Country
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(object.flag, style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${object.country} - ${object.city}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getProtocolColor(
                              object.protocol,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            object.protocol,
                            style: TextStyle(
                              color: _getProtocolColor(object.protocol),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getStatusColor(object.status),
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          object.status == 'completed' ? 'Success' : 'Failed',
                          style: TextStyle(
                            color: _getStatusColor(object.status),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                _formatTime(object.connectedAt),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Connection Details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Duration',
                  object.duration,
                  Icons.timer_outlined,
                ),
              ),
              // Expanded(
              //   child: _buildDetailItem(
              //     'Data Used',
              //     object.dataUsed,
              //     Icons.data_usage_outlined,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildDetailItem(String label, String value, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Color(0xFF00FF88).withOpacity(0.8), size: 16),
      SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}

Color _getStatusColor(String status) {
  return status == 'completed' ? Color(0xFF00FF88) : Color(0xFFFF4444);
}

Color _getProtocolColor(String protocol) {
  return protocol == 'WireGuard' ? Color(0xFF00FF88) : Color(0xFF4A90E2);
}

String _formatTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else {
    return '${difference.inMinutes}m ago';
  }
}
