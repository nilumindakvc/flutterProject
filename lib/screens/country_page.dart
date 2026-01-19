import 'package:flutter/material.dart';
import 'package:vpn/Data/data.dart';
import 'package:vpn/models/network_config.dart';
import 'package:vpn/services/network_service.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/theme/app_text_styles.dart';
import 'package:vpn/widgets/back_arrow_widget.dart';
import 'package:vpn/widgets/country_list_viewer_widget.dart';
import 'package:vpn/widgets/search_bar_widget.dart';
import 'package:vpn/models/country.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({
    super.key,
    required this.setCurrentCountry,
    required this.setCurrentCity,
    required this.setCurrentFlag,
    required this.setCurrentServer,
  });

  final void Function(String) setCurrentCountry;
  final void Function(String) setCurrentCity;
  final void Function(String) setCurrentFlag;
  final void Function(NetworkConfig) setCurrentServer;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  String _selectedCountry = '';

  final List<Country> _countries = [
    Country(
      name: 'Singapore',
      city: 'Singapore',
      flag: '🇸🇬',
      ping: '8ms',
      low: 'Low',
      premium: false,
    ),
    Country(
      name: 'Sweden',
      city: 'Stockholm',
      flag: '🇸🇪',
      ping: '15ms',
      low: 'Low',
      premium: false,
    ),
  ];

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
                    BackArrowWidget(onPress: () => Navigator.pop(context)),
                    SizedBox(width: 16),
                    Text('Select Server', style: AppTextStyles.appBarHeading),
                  ],
                ),
              ),

              // Search Bar
              SearchBarWidget(
                hintText: 'Search countries...',
                iconColor: AppColors.luminousGreen,
              ),

              SizedBox(height: 20),

              // Countries List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _countries.length,
                  itemBuilder: (context, index) {
                    final country = _countries[index];
                    final isSelected = _selectedCountry == country.name;

                    return CountryListViewerWidget(
                      country: country,
                      isSelected: isSelected,
                      callback: () {
                        setState(() {
                          _selectedCountry = country.name;
                          widget.setCurrentCountry(country.name);
                          widget.setCurrentCity(country.city);
                          widget.setCurrentFlag(country.flag);

                          // Set server configuration based on selected country
                          if (country.name == 'Singapore') {
                            widget.setCurrentServer(ServerData.severs[0]);
                          } else if (country.name == 'Sweden') {
                            widget.setCurrentServer(ServerData.severs[1]);
                          }
                        });
                      },
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
}
