import 'package:flutter/material.dart';
import 'package:vpn/screens/home_page.dart';
import 'package:vpn/services/authentication_service.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/widgets/back_arrow_widget.dart';
import 'package:vpn/widgets/circular_image_widget.dart';
import 'package:vpn/widgets/input_field_widget.dart';
import 'package:vpn/widgets/light_emiting_button_widget.dart';

class RegisteringPage extends StatefulWidget {
  const RegisteringPage({super.key});

  @override
  State<RegisteringPage> createState() => _RegisteringPageState();
}

class _RegisteringPageState extends State<RegisteringPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final AuthenticationService _authService = AuthenticationService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const headlineMedium = TextStyle(
      color: AppColors.luminousGreen,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.darkGradient,
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
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),

                        // Header Section
                        Center(
                          child: Column(
                            children: [
                              CircularImageWidget(
                                gradient: [
                                  const Color.fromARGB(255, 81, 255, 87),
                                  Colors.lightGreen,
                                ],
                                shadowColor: Colors.greenAccent,
                                blurRadius: 10,
                                spreadRadius: 6,
                                icon: Icons.person_add,
                              ),
                              SizedBox(height: 24),
                              Text(
                                'SecureLink',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Secure your digital life with premium protection',
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40),

                        // Personal Information
                        Text('Personal Information', style: headlineMedium),
                        SizedBox(height: 20),

                        // Username
                        InputFieldWidget(
                          controller: _usernameController,
                          label: 'Username',
                          icon: Icons.alternate_email,
                          helperText:
                              'Choose a unique username for your account',
                        ),

                        SizedBox(height: 20),

                        // Email
                        InputFieldWidget(
                          controller: _emailController,
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 32),

                        // Security Section
                        Text('Security', style: headlineMedium),
                        SizedBox(height: 20),

                        // Password
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
                          helperText:
                              'Must be at least 8 characters with numbers & symbols',
                        ),

                        SizedBox(height: 20),

                        // Confirm Password
                        InputFieldWidget(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscureConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: 32),

                        // Terms & Conditions
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _agreeToTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      _agreeToTerms = value ?? false;
                                    });
                                  },
                                  activeColor: AppColors.luminousGreen,
                                  checkColor: Colors.black,
                                  side: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 2,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(text: 'I agree to the '),
                                      TextSpan(
                                        text: 'Terms of Service',
                                        style: TextStyle(
                                          color: AppColors.luminousGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(text: ' and '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: AppColors.luminousGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 32),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.luminousGreen,
                                ),
                              )
                            : LightEmittingButtonWidget(
                                gradient: [
                                  AppColors.luminousGreen,
                                  Color(0xFF00CC6A),
                                ],
                                callback: _handleRegistration,
                                text: 'Create Account',
                              ),

                        SizedBox(height: 24),

                        // Login Link
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(text: 'Already have an account? '),
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: AppColors.luminousGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 32),
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

  Future<void> _handleRegistration() async {
    // Validate form
    if (_formKey.currentState?.validate() ?? false) {
      // Check if passwords match
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Passwords do not match'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        return;
      }

      // Check if terms are agreed
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Please agree to Terms of Service and Privacy Policy',
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final result = await _authService.registerWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (result['success']) {
        // Navigate to home page immediately
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
          
          // Show success message after navigation
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result['message']),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          });
        }
      } else {
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message']),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    }
  }
}
