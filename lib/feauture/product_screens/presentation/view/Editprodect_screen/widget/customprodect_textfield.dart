import 'package:flutter/material.dart';

class ProductTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int maxLines;

  const ProductTextField({
    super.key,
    this.maxLines = 1, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(

        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
