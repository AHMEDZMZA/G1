import 'package:flutter/material.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: heightScreen * .2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Container-5.png'),
                      fit: BoxFit.cover,
                    ),
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
                Container(
                  margin: EdgeInsets.only(
                    top: heightScreen * .035,
                    left: widthScreen * .035,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
            // SizedBox(height: heightScreen * .03),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widthScreen * .07,
                vertical: heightScreen * .03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: .2,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color(0xFF8D6E63),
                      child: SvgPicture.asset(
                        'assets/images/Icon (4).svg',
                        width: 36,
                        height: 36,
                        colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 120, 34, 2), // لون الأيقونة
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * .02),
                  Align(
                    //  alignment: Alignment.topLeft,
                    child: Text(
                      'Check Your Email',
                      style: TextStyle(
                        color: const Color(0xFF3E2723),
                        fontSize: 24,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * .02),
                  Text(
                    "We've sent a password reset link to",
                    style: TextStyle(
                      color: const Color(0xFF8D6E63),
                      fontSize: 16,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  SizedBox(height: heightScreen * .01),
                  Text(
                    "emanm0024@gmail.com",
                    style: TextStyle(
                      color: const Color(0xFF6D4C41),
                      fontSize: 16,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.bold,
                      height: 1.43,
                    ),
                  ),
                  SizedBox(height: heightScreen * .03),
                  Container(
                    width: widthScreen,
                    height: heightScreen * .1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFEFEBE9),
                    ),
                    child: Text(
                      "Didn't receive the email? Check your spam folder or try again.",
                      style: TextStyle(
                        color: const Color(0xFF8D6E63),
                        fontSize: 13,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: heightScreen * .09),
                  GestureDetector(
                    onTap: () {
                      // Continue as guest
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFFD7CCC8),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      width: double.infinity,
                      height: heightScreen * .05,
                      child: const Center(
                        child: Text(
                          'Resend Link',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF6D4C41),
                            fontSize: 15,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * .02),
                  GestureDetector(
                    onTap: () {
                      // Continue as guest
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Color(0xFF6D4C41),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFFD7CCC8),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      width: double.infinity,
                      height: heightScreen * .05,
                      child: const Center(
                        child: Text(
                          'Back to Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Need more help?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF8D6E63),
                          fontSize: 13.5,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                      // SizedBox(width: widthScreen * .03),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginView();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Contact Support',
                          style: TextStyle(
                            color: const Color(0xFF6D4C41),
                            fontSize: 13.5,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}