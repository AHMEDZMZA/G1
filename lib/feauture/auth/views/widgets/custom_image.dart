import 'package:flutter/material.dart';

class CustomImageAuth extends StatelessWidget {
  const CustomImageAuth({super.key, required this.image, this.height});
  final String image;
  final  height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width,
              height: height,
              fit: BoxFit.cover,
            ),
           
            Container(
              width: MediaQuery.of(context).size.width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.50, 0.00),
                  end: Alignment(0.50, 1.00),
                  colors: [
                    Colors.black.withValues(alpha: 0),
                    Colors.black.withValues(alpha: 0),
                    Color(0xFFFAF8F5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
