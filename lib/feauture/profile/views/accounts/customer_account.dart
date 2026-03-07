import 'package:flutter/material.dart';

class CustomerAccount extends StatelessWidget {
  const CustomerAccount({super.key, required this.onGoHome});

  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onGoHome?.call,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff6D4C41),
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 16,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
