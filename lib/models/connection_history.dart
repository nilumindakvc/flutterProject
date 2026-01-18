class ConnectionHistory {
  final String country;
  final String city;
  final String flag;
  final String protocol;
  final DateTime connectedAt;
  final DateTime disconnectedAt;
  final String duration;
  // final String dataUsed;
  final String status;

  ConnectionHistory({
    required this.country,
    required this.city,
    required this.flag,
    required this.protocol,
    required this.connectedAt,
    required this.disconnectedAt,
    required this.duration,
    // required this.dataUsed,
    required this.status,
  });
}
