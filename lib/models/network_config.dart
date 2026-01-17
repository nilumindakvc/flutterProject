class NetworkConfig {
  final String privateKey;
  final String address;
  final String dns;
  final String publicKey;
  final String preShearedKey;
  final String allowedIps;
  final String persistentKeepalive;
  final String endpoint;

  NetworkConfig({
    required this.privateKey,
    required this.address,
    required this.dns,
    required this.publicKey,
    required this.preShearedKey,
    required this.allowedIps,
    required this.persistentKeepalive,
    required this.endpoint,
  });
}
