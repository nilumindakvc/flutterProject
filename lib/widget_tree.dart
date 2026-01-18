import 'package:flutter/material.dart';
import 'package:vpn/screens/welcome_page.dart';

class WidgetTree extends StatelessWidget {
  WidgetTree({super.key, required this.toggleTheme});

  final VoidCallback toggleTheme;

  @override
  Widget build(BuildContext context) {
    return WelcomePage(toggleTheme: toggleTheme);
  }
}
