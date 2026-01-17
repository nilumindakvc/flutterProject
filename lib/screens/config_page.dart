import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  String _selectedProtocol = 'WireGuard';
  bool _autoConnect = true;
  bool _killSwitch = false;
  bool _dnsProtection = true;
  String _selectedDns = 'Cloudflare';

  @override
  Widget build(BuildContext context) {
    const luminousGreen = Color(0xFF00FF88);
    const darkBackground = Color(0xFF000000);

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
                    SizedBox(width: 16),
                    Text(
                      'Configuration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Settings Content
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: 20),

                    // VPN Protocol Section
                    _buildSectionHeader('VPN Protocol'),
                    SizedBox(height: 16),

                    // WireGuard Option
                    _buildProtocolOption(
                      title: 'WireGuard',
                      subtitle: 'Modern, fast, and secure protocol',
                      icon: Icons.security,
                      value: 'WireGuard',
                      isSelected: _selectedProtocol == 'WireGuard',
                      onTap: () {
                        setState(() {
                          _selectedProtocol = 'WireGuard';
                        });
                      },
                    ),

                    SizedBox(height: 12),

                    // OpenVPN Option
                    _buildProtocolOption(
                      title: 'OpenVPN',
                      subtitle: 'Traditional, reliable, and widely supported',
                      icon: Icons.vpn_lock,
                      value: 'OpenVPN',
                      isSelected: _selectedProtocol == 'OpenVPN',
                      onTap: () {
                        setState(() {
                          _selectedProtocol = 'OpenVPN';
                        });
                      },
                    ),

                    SizedBox(height: 32),

                    // Connection Settings Section
                    _buildSectionHeader('Connection Settings'),
                    SizedBox(height: 16),

                    _buildSwitchOption(
                      title: 'Auto Connect',
                      subtitle: 'Automatically connect on app startup',
                      icon: Icons.power_settings_new,
                      value: _autoConnect,
                      onChanged: (value) {
                        setState(() {
                          _autoConnect = value;
                        });
                      },
                    ),

                    SizedBox(height: 12),

                    _buildSwitchOption(
                      title: 'Kill Switch',
                      subtitle: 'Block internet if VPN disconnects',
                      icon: Icons.block,
                      value: _killSwitch,
                      onChanged: (value) {
                        setState(() {
                          _killSwitch = value;
                        });
                      },
                    ),

                    SizedBox(height: 32),

                    // DNS Settings Section
                    _buildSectionHeader('DNS Settings'),
                    SizedBox(height: 16),

                    _buildSwitchOption(
                      title: 'DNS Protection',
                      subtitle: 'Use secure DNS servers',
                      icon: Icons.dns,
                      value: _dnsProtection,
                      onChanged: (value) {
                        setState(() {
                          _dnsProtection = value;
                        });
                      },
                    ),

                    if (_dnsProtection) ...[
                      SizedBox(height: 12),
                      _buildDropdownOption(
                        title: 'DNS Provider',
                        icon: Icons.cloud,
                        value: _selectedDns,
                        options: ['Cloudflare', 'Google', 'Quad9', 'Custom'],
                        onChanged: (value) {
                          setState(() {
                            _selectedDns = value!;
                          });
                        },
                      ),
                    ],

                    SizedBox(height: 32),

                    // Advanced Settings Section
                    _buildSectionHeader('Advanced'),
                    SizedBox(height: 16),

                    _buildActionOption(
                      title: 'Export Configuration',
                      subtitle: 'Save current settings',
                      icon: Icons.file_download,
                      onTap: () {
                        // Export functionality
                      },
                    ),

                    SizedBox(height: 12),

                    _buildActionOption(
                      title: 'Import Configuration',
                      subtitle: 'Load settings from file',
                      icon: Icons.file_upload,
                      onTap: () {
                        // Import functionality
                      },
                    ),

                    SizedBox(height: 12),

                    _buildActionOption(
                      title: 'Reset to Defaults',
                      subtitle: 'Restore original settings',
                      icon: Icons.restore,
                      onTap: () {
                        setState(() {
                          _selectedProtocol = 'WireGuard';
                          _autoConnect = true;
                          _killSwitch = false;
                          _dnsProtection = true;
                          _selectedDns = 'Cloudflare';
                        });
                      },
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    const luminousGreen = Color(0xFF00FF88);
    return Text(
      title,
      style: TextStyle(
        color: luminousGreen,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildProtocolOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    const luminousGreen = Color(0xFF00FF88);

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? luminousGreen.withOpacity(0.1)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? luminousGreen : Colors.white.withOpacity(0.1),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? luminousGreen.withOpacity(0.2)
                        : Colors.white.withOpacity(0.1),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? luminousGreen
                        : Colors.white.withOpacity(0.8),
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? luminousGreen
                          : Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                    color: isSelected ? luminousGreen : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(Icons.check, color: Colors.black, size: 16)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    const luminousGreen = Color(0xFF00FF88);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: luminousGreen, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: luminousGreen,
              activeTrackColor: luminousGreen.withOpacity(0.3),
              inactiveThumbColor: Colors.white.withOpacity(0.8),
              inactiveTrackColor: Colors.white.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownOption({
    required String title,
    required IconData icon,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    const luminousGreen = Color(0xFF00FF88);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: luminousGreen, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              dropdownColor: Color(0xFF1A1A1A),
              style: TextStyle(color: Colors.white),
              underline: Container(),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    const luminousGreen = Color(0xFF00FF88);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: luminousGreen, size: 24),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
