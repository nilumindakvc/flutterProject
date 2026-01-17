import 'package:flutter/material.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: AppColors.luminousGreen,
          ),

          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),

          bodySmall: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: WidgetTree(),
    );
  }
}
