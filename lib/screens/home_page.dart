import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vpn/models/connection_history.dart';
import 'package:vpn/models/network_config.dart';
import 'package:vpn/screens/config_page.dart';
import 'package:vpn/screens/country_page.dart';
import 'package:vpn/screens/historyPage/history_page.dart';
import 'package:vpn/services/authentication_service.dart';
import 'package:vpn/services/network_service.dart';
import 'package:vpn/widgets/circular_action_button_widget.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.toggleTheme});

  final VoidCallback? toggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isVpnEnabled = false;
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  String country = "Germany";
  String city = "Berlin";
  String flag = '🇩🇪';

  DateTime connectionStart = DateTime.now();
  DateTime connectionEnd = DateTime.now();
  Timer? _connectionTimer;
  Duration _elapsedTime = Duration.zero;

  final AuthenticationService _authService = AuthenticationService();

  final List<ConnectionHistory> _connectionHistory = [
    ConnectionHistory(
      country: 'United States',
      city: 'New York',
      flag: '🇺🇸',
      protocol: 'WireGuard',
      connectedAt: DateTime.now().subtract(Duration(hours: 2)),
      disconnectedAt: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
      duration: '30 min',
      status: 'completed',
    ),
    ConnectionHistory(
      country: 'United Kingdom',
      city: 'London',
      flag: '🇬🇧',
      protocol: 'OpenVPN',
      connectedAt: DateTime.now().subtract(Duration(hours: 5)),
      disconnectedAt: DateTime.now().subtract(Duration(hours: 3, minutes: 15)),
      duration: '1h 45m',
      status: 'completed',
    ),
  ];

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
    _connectionTimer?.cancel();
    super.dispose();
  }

  void setCountry(String newCountry) {
    setState(() {
      country = newCountry;
    });
  }

  void setCity(String newCity) {
    setState(() {
      city = newCity;
    });
  }

  void setFlag(String newFlag) {
    setState(() {
      flag = newFlag;
    });
  }

  void historyInserter() {
    Duration connectionDuration = connectionEnd.difference(connectionStart);
    String formattedDuration = _formatConnectionDuration(connectionDuration);

    var historyElement = ConnectionHistory(
      country: country,
      city: city,
      flag: flag,
      protocol: 'WireGuard',
      connectedAt: connectionStart,
      disconnectedAt: connectionEnd,
      duration: formattedDuration,
      status: 'completed',
    );
    _connectionHistory.add(historyElement);
  }

  void historyClearer() {
    setState(() {
      _connectionHistory.clear();
    });
  }

  String _formatConnectionDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void _startConnectionTimer() {
    _connectionTimer?.cancel();
    _connectionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = DateTime.now().difference(connectionStart);
      });
    });
  }

  void _stopConnectionTimer() {
    _connectionTimer?.cancel();
    _connectionTimer = null;
    connectionEnd = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    const luminousGreen = Color.fromARGB(255, 0, 255, 60);
    const redColor = Color.fromARGB(255, 255, 0, 0);

    // Use theme colors instead of hardcoded ones
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [Color(0xFF000000), Color(0xFF0A0A0A), Color(0xFF111111)]
                : [Color(0xFFF5F5F5), Color(0xFFE0E0E0), Color(0xFFD0D0D0)],
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
                                color: isDark ? Colors.white : Colors.black,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'SecureLink',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
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
                            onPressed: () {
                              widget.toggleTheme!();
                            },
                            icon: Icon(
                              Icons.dark_mode,
                              color: isDark ? Colors.white : Colors.black,
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

                          // child:IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     Icons.settings,
                          //     color: Colors.white,
                          //     size: 20,
                          //   ),
                          // ),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Text(flag, style: TextStyle(fontSize: 20)),
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

                    // Connection Timer Display (only when VPN is enabled)
                    if (_isVpnEnabled) ...[
                      Text(
                        'Connected for',
                        style: TextStyle(
                          color: isDark
                              ? Colors.white.withOpacity(0.6)
                              : Colors.black.withOpacity(0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _formatDuration(_elapsedTime),
                        style: TextStyle(
                          color: luminousGreen,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 20),
                    ],

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
                        color: isDark
                            ? Colors.white.withOpacity(0.8)
                            : Colors.black.withOpacity(0.8),
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
                                    return CountryPage(
                                      setCurrentCountry: setCountry,
                                      setCurrentCity: setCity,
                                      setCurrentFlag: setFlag,
                                    );
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
                                    return HistoryPage(
                                      connectionHistory: _connectionHistory,
                                      historyClere: historyClearer,
                                    );
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

      // Set connection start time BEFORE starting timer
      connectionStart = DateTime.now();
      _elapsedTime = Duration.zero;
      _startConnectionTimer();

      setState(() {
        _isVpnEnabled = true;
      });

      netService.getVpnStages().listen((event) {
        print(event);
      });
    } else {
      await netService.stopServer();

      // Stop timer and save history
      _stopConnectionTimer();
      historyInserter();

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
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/', (route) => false);
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
