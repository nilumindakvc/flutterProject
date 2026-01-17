import 'package:flutter/material.dart';
import 'package:vpn/screens/home_page.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/widgets/back_arrow_widget.dart';
import 'package:vpn/widgets/circular_image_widget.dart';
import 'package:vpn/widgets/input_field_widget.dart';
import 'package:vpn/widgets/light_emiting_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
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
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 60),

                        // Header Section
                        CircularImageWidget(
                          gradient: [
                            Colors.greenAccent,
                            Colors.lightGreenAccent,
                          ],
                          shadowColor: Colors.greenAccent,
                          blurRadius: 10,
                          spreadRadius: 10,
                          icon: Icons.shield_outlined,
                        ),

                        SizedBox(height: 40),

                        Text(
                          'SecureLink',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Sign in to your secure connection',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),

                        SizedBox(height: 60),

                        // Email Field
                        InputFieldWidget(
                          controller: _emailController,
                          label: 'Email or Username',
                          icon: Icons.person_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 24),

                        // Password Field
                        InputFieldWidget(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: 20),

                        // Remember Me & Forgot Password Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    activeColor: AppColors.luminousGreen,
                                    checkColor: Colors.black,
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                // Forgot password functionality can be added here
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: AppColors.luminousGreen,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40),

                        // Login Button
                        LightEmittingButtonWidget(
                          gradient: [
                            AppColors.luminousGreen,
                            Color(0xFF00CC6A),
                          ],
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          },
                          text: 'Sign In',
                        ),

                        SizedBox(height: 32),

                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white.withOpacity(0.2),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white.withOpacity(0.2),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 32),

                        // Biometric Login Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(28),
                              onTap: () {
                                // Biometric login functionality can be added here
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.fingerprint,
                                    color: AppColors.luminousGreen,
                                    size: 24,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Use Biometric',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),

                        // Sign Up Link
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: AppColors.luminousGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
