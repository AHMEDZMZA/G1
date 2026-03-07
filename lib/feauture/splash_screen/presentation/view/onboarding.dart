import 'package:flutter/material.dart';
import 'package:graduation2/feauture/auth/views/register_screen.dart';
import 'package:graduation2/feauture/splash_screen/data/models/onboarding_model.dart';
import 'package:graduation2/feauture/splash_screen/presentation/view/widget/onboarding_view.dart';
import 'package:graduation2/feauture/typeof%20person/view/type_of_person.dart';

import '../../../auth/views/login_screen.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _controller = PageController();
  int index = 0;

  List<OnBoardingModel> onBoardingModel = [
    OnBoardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Discover Unique Crafts',
      description:
          'Explore handmade treasures from talented artisans worldwide',
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Connect with Sellers',
      description: 'Build relationships with passionate creators and suppliers',
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Share Your Creativity',
      description: 'Join our community and showcase your handmade masterpieces',
    ),
  ];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF8F5),
        title: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginView();
                    },
                  ),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Arimo',
                  color: Color(0xFF8D6E63),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListOnBoardingView(
                          onBoardingModel: onBoardingModel[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * .001),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIndicator(active: index == 0),
                  SizedBox(width: 5),
                  CustomIndicator(active: index == 1),
                  SizedBox(width: 5),
                  CustomIndicator(active: index == 2),
                ],
              ),

              SizedBox(height: size.height * 0.07),
              InkWell(
                onTap: () {
                  if (index == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginView()),
                    );
                  } else {
                    _controller.animateToPage(
                      index + 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  width: size.width,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
                    ),
                  ),
                  child: Text(
                    index == 2 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * .02),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? Color(0xFF6D4C41) : Colors.grey,
      ),
      width: active ? 30 : 10,
      height: 10,
    );
  }
}
