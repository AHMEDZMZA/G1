import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * .01,
      ),
      alignment: Alignment.topLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: const Color(0xFF3E2723),
          fontSize: 16,
          fontFamily: 'Arimo',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
