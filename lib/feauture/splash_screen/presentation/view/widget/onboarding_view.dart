import 'package:flutter/material.dart';
import 'package:graduation2/feauture/splash_screen/data/models/onboarding_model.dart';

class ListOnBoardingView extends StatelessWidget {
  const ListOnBoardingView({super.key, required this.onBoardingModel});
  final OnBoardingModel onBoardingModel;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * .35,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Image.asset(onBoardingModel.image, fit: BoxFit.cover),
        ),
        SizedBox(height: size.height * 0.04),
        Text(
          onBoardingModel.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 26,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        SizedBox(height: size.height * .01),
        Text(
          onBoardingModel.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF8D6E63),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
