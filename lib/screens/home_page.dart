import 'package:flutter/material.dart';
import 'package:vpn/models/network_config.dart';
import 'package:vpn/screens/config_page.dart';
import 'package:vpn/screens/country_page.dart';
import 'package:vpn/screens/historyPage/history_page.dart';
import 'package:vpn/services/authentication_service.dart';
import 'package:vpn/services/network_service.dart';
import 'package:vpn/widgets/circular_action_button_widget.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isVpnEnabled = false;
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;
  final AuthenticationService _authService = AuthenticationService();

  final NetworkService netService = NetworkService(
    configObj: NetworkConfig(
      privateKey: "CEnPPC46zeivARsfOhL1NaiIzeh/oB3fUdC+YyrhkH4=",
      address: "10.66.66.2/32, fd42:42:42::2/128",
      dns: "1.1.1.1, 1.0.0.1",
      publicKey: "/ptJU0VjaZL7mouPky+0KozxHa2peS3wDxYcXNALZDU=",
      preShearedKey: "Hn8rm2jDrVTDYZEcSs+VM9e2O2l1o2AEYRSyfvvECoI=",
      allowedIps: "0.0.0.0/0, ::/0",
      persistentKeepalive: "0",
      endpoint: "140.245.114.17:57359",
    ),
    wireguard: WireGuardFlutter.instance,
  );

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const luminousGreen = Color.fromARGB(255, 0, 255, 60);
    const darkBackground = Color(0xFF000000);
    const redColor = Color.fromARGB(255, 255, 0, 0);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF0A0A0A), Color(0xFF111111)],
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
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'SecureLink',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.dark_mode,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.3),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _showLogoutDialog(context);
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // VPN Status Section with Animated Icon
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Status Text
                    Text(
                      _isVpnEnabled ? 'PROTECTED' : 'NOT PROTECTED',
                      style: TextStyle(
                        color: _isVpnEnabled ? luminousGreen : redColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),

                    SizedBox(height: 20),

                    // Animated VPN Status Icon
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer pulsing ring
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        (_isVpnEnabled
                                                ? luminousGreen
                                                : redColor)
                                            .withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // Middle ring
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: (_isVpnEnabled ? luminousGreen : redColor)
                                  .withOpacity(0.5),
                              width: 3,
                            ),
                          ),
                        ),
                        // Inner rotating ring (only when enabled)
                        if (_isVpnEnabled)
                          AnimatedBuilder(
                            animation: _rotateAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotateAnimation.value * 2 * 3.14159,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ).withOpacity(0.8),
                                      width: 5,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        // Center button
                        GestureDetector(
                          onTap: () {
                            enableOrDisableVpn(netService);
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isVpnEnabled ? luminousGreen : redColor,

                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (_isVpnEnabled ? luminousGreen : redColor)
                                          .withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              _isVpnEnabled
                                  ? Icons.shield
                                  : Icons.shield_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    // Status Description
                    Text(
                      _isVpnEnabled
                          ? 'Your connection is secure and private'
                          : 'Tap to enable secure connection',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 50),

                    // Action Buttons - Circular Layout
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularActionButtonWidget(
                            icon: Icons.public,
                            label: 'Country',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const CountryPage();
                                  },
                                ),
                              );
                            },
                            color: Colors.lightBlueAccent,
                          ),
                          CircularActionButtonWidget(
                            icon: Icons.settings,
                            label: 'Config',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ConfigurationPage();
                                  },
                                ),
                              );
                            },
                            color: luminousGreen,
                          ),
                          CircularActionButtonWidget(
                            icon: Icons.history,
                            label: 'History',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HistoryPage();
                                  },
                                ),
                              );
                            },
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void enableOrDisableVpn(NetworkService netService) async {
    if (_isVpnEnabled == false) {
      await netService.startServer();

      setState(() {
        _isVpnEnabled = true;
      });

      _isVpnEnabled = true;
      netService.getVpnStages().listen((event) {
        print(event);
      });
    } else {
      await netService.stopServer();

      setState(() {
        _isVpnEnabled = false;
      });
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.red.withOpacity(0.3), width: 1),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.red, size: 24),
              SizedBox(width: 12),
              Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog first
                
                // Disconnect VPN if enabled
                if (_isVpnEnabled) {
                  await netService.stopServer();
                }

                // Sign out from Firebase
                await _authService.signOut();

                // Navigate back to welcome screen
                if (mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
