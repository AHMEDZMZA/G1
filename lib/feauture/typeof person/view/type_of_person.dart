import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation2/feauture/auth/views/enter_code_screen.dart';
import 'package:graduation2/feauture/auth/views/enter_email.dart';
import 'package:graduation2/feauture/auth/views/register_screen.dart';

import '../../../core/const/role_const.dart';
import 'Beginner_Expert.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  // دلوقتي leadingWidget ممكن يكون Icon أو Image
  Widget buildRoleCard(
    BuildContext context,
    String title,
    String subtitle,
    Widget leadingWidget, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // 🟤 دائرة للأيقونة أو الصورة
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF6D4C41),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(child: leadingWidget),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.arimo(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3E2723),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.arimo(
                    fontSize: 12,
                    color: const Color(0xFF8D6E63),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Center(
                child: Text(
                  "Join Craftoria",
                  style: GoogleFonts.arimo(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF3E2723),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  "Select your role to continue",
                  style: GoogleFonts.arimo(
                    fontSize: 13,
                    color: const Color(0xFF8D6E63),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              buildRoleCard(
                context,
                "Customer",
                "Browse and buy unique\nhandmade items",
                Image.asset(
                  'assets/images/supplier2.png',
                  width: 22,
                  height: 22,
                  color: Colors.white, // تقدر تشيله لو الصورة ملونة
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>   CheckEmailScreen(role: UserRole.customer),),
                  );
                },
              ),
              buildRoleCard(
                context,
                "Seller",
                "Sell your handcrafted creations",
                Image.asset(
                  'assets/images/home.png',
                  width: 22,
                  height: 22,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SellerTypeScreen()),
                  );
                },
              ),
              buildRoleCard(
                context,
                "Supplier",
                "Provide materials and resources",
                Image.asset(
                  'assets/images/Icon (5).png',
                  width: 22,
                  height: 22,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  CheckEmailScreen(role: UserRole.supplier)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
