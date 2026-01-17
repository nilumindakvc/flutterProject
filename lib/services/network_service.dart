import 'package:vpn/models/network_config.dart';
import 'package:wireguard_flutter/wireguard_flutter_platform_interface.dart';

class NetworkService {
  final NetworkConfig configObj;
  final WireGuardFlutterInterface wireguard;

  NetworkService({required this.configObj, required this.wireguard});

  //this will start the server
  Future<void> startServer() async {
    await wireguard.initialize(interfaceName: 'wg0');

    String conf = _ConfigStringMaker(configObj);

    await wireguard.startVpn(
      serverAddress: configObj.endpoint,
      wgQuickConfig: conf,
      providerBundleIdentifier: 'com.example',
    );
  }

  //this will stop the server
  Future<void> stopServer() async {
    await wireguard.stopVpn();
  }

  // This function gives your VPN events as strings.
  Stream<String> getVpnStages() {
    return wireguard.vpnStageSnapshot.map((event) => event.toString());
  }

  // helper method to build the configuration string
  String _ConfigStringMaker(NetworkConfig configObj) {
    String conf =
        '''[Interface]
    PrivateKey = ${configObj.privateKey}
    Address = ${configObj.address}
    DNS = ${configObj.dns}


    [Peer]
    PublicKey = ${configObj.publicKey}
    PresharedKey = ${configObj.preShearedKey}
    AllowedIPs = ${configObj.allowedIps}, ::/0
    PersistentKeepalive = ${configObj.persistentKeepalive}
    Endpoint = ${configObj.endpoint}''';
    return conf;
  }
}
