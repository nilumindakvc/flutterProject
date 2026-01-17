import 'package:flutter/material.dart';
import 'package:vpn/screens/login_page.dart';
import 'package:vpn/screens/onboard_page.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/widgets/repeat_pulse_widget.dart';
import 'package:vpn/widgets/sized_boxed_infinity_button_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Simple color scheme - deep black with luminous green
    const luminousGreen = Color(0xFF00FF88);
    const darkBackground = Color(0xFF000000);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: darkBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                const Spacer(),

                // Logo and Welcome Section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        // Simple VPN Shield Icon
                        RepeatPulsingWidget(
                          vsync: this,
                          color: AppColors.luminousGreen,
                          icon: Icons.shield,
                        ),
                        const SizedBox(height: 50),
                        // App Name
                        Text(
                          'MyVPN',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Secure. Private. Protected.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Action Buttons
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      SizedBoxedInfinityButtonWidget(
                        forcolor: Colors.black,
                        backcolor: luminousGreen,
                        text: 'Get Started',
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const OnboardPage();
                              },
                            ),
                          );
                        },
                        type: 'elevated',
                      ),

                      const SizedBox(height: 16),

                      // Simple Login Button
                      SizedBoxedInfinityButtonWidget(
                        forcolor: luminousGreen,
                        backcolor: Colors.black,
                        text: 'Login',
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        },
                        type: 'outline',
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
