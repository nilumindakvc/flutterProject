import 'package:vpn/models/network_config.dart';

class ServerData {
  static final List<NetworkConfig> severs = [
    NetworkConfig(
      privateKey: "CEnPPC46zeivARsfOhL1NaiIzeh/oB3fUdC+YyrhkH4=",
      address: "10.66.66.2/32, fd42:42:42::2/128",
      dns: "1.1.1.1, 1.0.0.1",
      publicKey: "/ptJU0VjaZL7mouPky+0KozxHa2peS3wDxYcXNALZDU=",
      preShearedKey: "Hn8rm2jDrVTDYZEcSs+VM9e2O2l1o2AEYRSyfvvECoI=",
      allowedIps: "0.0.0.0/0, ::/0",
      persistentKeepalive: "0",
      endpoint: "140.245.114.17:57359",
    ),
    NetworkConfig(
      privateKey: "mGoJrIPycofyqouXKyoGg3teMXUDme2cTXWJ+65rhW4=",
      address: "10.0.0.2/32",
      dns: "1.1.1.1",
      publicKey: "YHTsAKVUY1WsZcAeuquf5ql1WQFuDGdh0DxprJZX7mM=",
      preShearedKey: "3fwpuIQLbQ/uHEd/2xRJwtB+0OZTgW828JhcyQ25OIs=",
      allowedIps: "0.0.0.0/0",
      persistentKeepalive: "25",
      endpoint: "13.53.42.242:51820",
    ),
  ];
}
