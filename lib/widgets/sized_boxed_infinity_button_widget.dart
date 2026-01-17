import 'package:flutter/material.dart';

class SizedBoxedInfinityButtonWidget extends StatelessWidget {
  const SizedBoxedInfinityButtonWidget({
    super.key,
    required this.forcolor,
    required this.backcolor,
    required this.text,
    required this.callback,
    required this.type,
  });

  final Color forcolor;
  final Color backcolor;
  final String text;
  final String type;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    if (type == 'elevated') {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            backgroundColor: backcolor,
            foregroundColor: forcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else if (type == 'outline') {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: OutlinedButton(
          onPressed: callback,
          style: OutlinedButton.styleFrom(
            foregroundColor: forcolor,
            side: BorderSide(color: forcolor, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
