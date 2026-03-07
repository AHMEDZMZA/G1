import 'package:flutter/material.dart';
import 'package:graduation2/core/rescources/colors.dart' show AppColors;
import 'package:graduation2/feauture/splash_screen/presentation/view/onboarding.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OnBoardingView();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.6),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/splash.png'),
                    radius: 82,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Craftoria',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5A3E36),
                  letterSpacing: 1.2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1.00, 0.50),
                        end: Alignment(0.00, 0.50),
                        colors: [
                          Colors.black.withValues(alpha: 0),
                          const Color(0x7FC9A874),
                          const Color(0x33C9A874),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 11,
                    height: 11,
                    decoration: ShapeDecoration(
                      color: const Color(0x4CC9A875),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(44739200),
                      ),
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1.00, 0.50),
                        end: Alignment(0.00, 0.50),
                        colors: [
                          Colors.black.withValues(alpha: 0),
                          const Color(0x7FC9A874),
                          const Color(0x33C9A874),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Where Craftsmanship Meets Community',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7A5D4E),
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'HANDMADE WITH LOVE',
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 2,
                  color: Color(0xffB49A84),
                ),
              ),

              const SizedBox(height: 40),

              Column(
                children: [
                  Container(
                    width: 140,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xffDCC6B0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 60,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xff5A3E36),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'LOADING',
                    style: TextStyle(
                      color: Color(0xffB49A84),
                      fontSize: 13,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔸 Dot builder
  Widget buildDot(bool isActive) {
    return Container(
      width: isActive ? 10 : 6,
      height: isActive ? 10 : 6,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xff5A3E36)
            : const Color(0xffCBB6A5).withOpacity(0.6),
        shape: BoxShape.circle,
      ),
    );
  }
}





  //              SizedBox(height: MediaQuery.of(context).size.height * .2),

              // ⚪ Page Indicators
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     _buildDot(true),
              //     const SizedBox(width: 8),
              //     _buildDot(false),
              //     const SizedBox(width: 8),
              //     _buildDot(false),
              //   ],
              // ),