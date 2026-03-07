import 'package:flutter/material.dart';

import '../../../../../core/rescources/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Craftoria",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.kTextDark,
          ),
        ),
        Row(
          children: const [
            Icon(Icons.notifications_none, color:AppColors.kTextDark),
            SizedBox(width: 12),
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ],
        ),
      ],
    );
  }
}
