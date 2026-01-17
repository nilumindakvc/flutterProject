import 'package:flutter/material.dart';

class RepeatPulsingWidget extends StatefulWidget {
  const RepeatPulsingWidget({
    super.key,
    required this.vsync,
    required this.icon,
    required this.color,
  });

  final TickerProvider vsync;
  final IconData icon;
  final Color color;

  @override
  State<RepeatPulsingWidget> createState() => _RepeatPulsingWidgetState();
}

class _RepeatPulsingWidgetState extends State<RepeatPulsingWidget> {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: widget.vsync,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: widget.color, width: 2),
        ),
        child: Icon(widget.icon, size: 50, color: widget.color),
      ),
    );
  }
}
