import 'package:flutter/material.dart';

class NumberOfType extends StatelessWidget {
  const NumberOfType({super.key, required this.number, required this.type});
  final int number;
  final String type;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 15.57,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
        ),
        SizedBox(height: height * .01),
        Text(
          type,
          style: TextStyle(
            color: const Color(0xFF8D6E63),
            fontSize: 15.57,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }
}
