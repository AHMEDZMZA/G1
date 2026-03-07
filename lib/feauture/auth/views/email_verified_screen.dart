import 'package:flutter/material.dart';
import 'package:graduation2/feauture/auth/views/enter_code_screen.dart';
import 'package:graduation2/feauture/auth/views/widgets/custom_button.dart';

class EmailVerifiedScreen extends StatelessWidget {
  final String email;
  final String role;
  EmailVerifiedScreen({super.key, required this.email, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xffA5D6A7),
              child: Icon(
                Icons.check_circle_outline,
                color: Color(0xff2E7D32),
                size: 40,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Email Verified!',
              style: TextStyle(
                color: Color(0xFF3E2723),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We found your email: $email",
              style: TextStyle(
                color: const Color(0xFF8D6E63),
                fontSize: 16,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              buttonText: 'Send code',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EnterCodeScreen(email: email, role: role);
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Widget _buildLabel(String text) {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 8, top: 12),
  //       child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  //     ),
  //   );
  // }
}
