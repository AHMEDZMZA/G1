import 'package:flutter/material.dart';

import '../../../../../core/rescources/colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;
  final VoidCallback? onTap; // أضيفي هذا السطر

  const SectionTitle({
    super.key,
    required this.title,
    this.trailing,
    this.onTap, // أضيفي هذا السطر
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4E342E)),
        ),
        if (trailing != null)
          GestureDetector(
            onTap: onTap, // ربط الحركة هنا
            child: Text(
              trailing!,
              style: const TextStyle(color: Colors.brown, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}