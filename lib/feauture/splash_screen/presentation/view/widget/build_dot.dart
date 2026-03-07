import 'package:flutter/material.dart';

Widget buildDot(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    height: 8,
    width: isActive ? 20 : 8,
    decoration: BoxDecoration(
      gradient: isActive
          ? const LinearGradient(
              begin: Alignment(0.50, 0.00),
              end: Alignment(0.50, 1.00),
              colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
            )
          : null,
      color: isActive ? null : const Color(0xFFD7CCC8),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
