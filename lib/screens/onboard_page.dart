import 'package:flutter/material.dart';
import 'package:vpn/models/onboard_item.dart';
import 'package:vpn/screens/registering_page.dart';
import 'package:vpn/theme/app_colors.dart';
import 'package:vpn/widgets/back_arrow_widget.dart';
import 'package:vpn/widgets/light_emiting_button_widget.dart';
import 'package:vpn/widgets/onetime_pulse_widget.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      icon: Icons.security,
      title: "Ultimate Security",
      description:
          "Military-grade encryption protects your data from hackers and surveillance",
      gradient: [Color(0xFF00FF88), Color(0xFF00CC6A)],
    ),
    OnboardingItem(
      icon: Icons.flash_on,
      title: "Lightning Fast",
      description:
          "Optimized servers worldwide ensure blazing-fast connection speeds",
      gradient: [
        Color.fromARGB(255, 6, 86, 185),
        Color.fromARGB(255, 32, 214, 255),
      ],
    ),
    OnboardingItem(
      icon: Icons.language,
      title: "Global Access",
      description:
          "Connect to servers in 50+ countries and access content from anywhere",
      gradient: [
        Color.fromARGB(255, 118, 255, 50),
        Color.fromARGB(255, 255, 255, 255),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Stack(
        children: [
          // Animated background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.blueGradient,
              ),
            ),
          ),
          // Floating particles effect
          ...List.generate(6, (index) => _buildFloatingParticle(index)),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top navigation
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      BackArrowWidget(onPress: _handleBackNavigation),
                      if (_currentPage < _onboardingItems.length - 1)
                        TextButton(
                          onPressed: () => _skipToEnd(),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // PageView content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onboardingItems.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildOnboardingPage(_onboardingItems[index]);
                    },
                  ),
                ),
                // Bottom section
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      // Page indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingItems.length,
                          (index) => _buildPageIndicator(index),
                        ),
                      ),
                      SizedBox(height: 40),
                      LightEmittingButtonWidget(
                        gradient: [Color(0xFF00FF88), Color(0xFF00CC6A)],
                        callback: () {
                          if (_currentPage < _onboardingItems.length - 1) {
                            _nextPage();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegisteringPage();
                                },
                              ),
                            );
                          }
                        },
                        text: (_currentPage < _onboardingItems.length - 1)
                            ? 'Continue'
                            : 'Get Started',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon container
          OnetimePulseWidget(gradient: item.gradient, icon: item.icon),
          SizedBox(height: 60),
          // Title
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // Description
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    bool isActive = index == _currentPage;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF00FF88) : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: (index * 100.0) % screenHeight,
      left: (index * 50.0) % screenWidth,
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 3 + index),
        tween: Tween<double>(begin: 0, end: 1),
        onEnd: () {
          // Restart animation
          setState(() {});
        },
        builder: (context, double value, child) {
          return Transform.translate(
            offset: Offset(0, -50 * value),
            child: Opacity(
              opacity: (1 - value) * 0.6,
              child: Container(
                width: 4 + (index % 3) * 2,
                height: 4 + (index % 3) * 2,
                decoration: BoxDecoration(
                  color: Color(0xFF00FF88).withOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00FF88).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _onboardingItems.length - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleBackNavigation() {
    if (_currentPage > 0) {
      // Go to previous onboarding screen
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Go back to welcome page
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
