import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final bool isSelected;
  final String imagePath;

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.isSelected,

    required this.title,
    required this.subtitle,
    required this.onTap, required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFC8A97E)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),

            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0XFF3E2723)
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff8D6A63),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xFFC8A97E),
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}