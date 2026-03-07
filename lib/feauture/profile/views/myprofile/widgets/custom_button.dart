import 'package:flutter/material.dart';

class CustomButtonprofile extends StatelessWidget {
  const CustomButtonprofile({
    super.key,
    required this.text,
    required this.icon,
    required this.color1,
    required this.color2,
    this.message = false,
  });
  final String text;
  final IconData icon;
  final Color color1;
  final Color color2;
  final bool message;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: height * 0.04,
          width: width * .28,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment(0.50, 0.00),
              end: Alignment(0.50, 1.00),
              colors: [color1, color2],
            ),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 16),

                  Text(
                    ' $text',
                    style: TextStyle(color: Colors.white, fontFamily: 'Arimo'),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (message)
          Container(
            width: width * .045,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xFFFF4081),
            ),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Arimo',
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
