import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const ContinueButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,

      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF6D4C41),
              Color(0xFF8D6E63),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            "Continue",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

  }
}