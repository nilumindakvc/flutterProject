import 'package:flutter/material.dart';

class BinWidget extends StatelessWidget {
  const BinWidget({super.key, required this.callback});

  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: IconButton(
        onPressed: callback,
        icon: Icon(Icons.delete_outline, color: Colors.white, size: 20),
      ),
    );
  }
}
