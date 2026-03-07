import 'package:flutter/material.dart';
import 'package:graduation2/feauture/auth/views/enter_email.dart';

import '../../../core/const/role_const.dart';
import '../../auth/views/register_screen.dart';



class SellerTypeScreen extends StatelessWidget {
  const SellerTypeScreen({super.key});

  Widget buildTypeCard({
    required String title,
    required String desc,
    required List<String> features,
    required Color mainColor, // ✅ اللون الأساسي لكل كارت
    Widget? leadingWidget,
    VoidCallback? onTap,
    bool elevated = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border.all(color: mainColor.withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: mainColor.withOpacity(elevated ? 0.25 : 0.12),
              blurRadius: elevated ? 10 : 6,
              offset: Offset(2, elevated ? 5 : 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (leadingWidget != null)
                  Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: mainColor, // ✅ المربع الملون حول الأيقونة
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: leadingWidget),
                  ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.only(left: 44), // (32 icon + 12 margin)
              child: Text(
                desc,
                style: const TextStyle(fontSize: 13, color: Color(0xFF8D6E63)),
              ),
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF8F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Features:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...features.map(
                        (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.circle,
                              size: 6, color: Color(0xFF3E2723)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              f,
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xFF3E2723)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEBE9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Choose Seller Type",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 17.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF3E2723)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "Choose your seller type to continue",
              style: TextStyle(color: Color(0xFF8D6E63)),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: [
                  // 🟤 كارت Beginner
                  buildTypeCard(
                    title: "Beginner (Junior)",
                    desc: "Start your journey as a new seller",
                    features: [
                      "List and sell handmade products",
                    ],
                    mainColor: const Color(0xFF8D6E63),
                    leadingWidget: Image.asset(
                      "assets/images/star.png",
                      width: 24,
                      height: 24,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  CheckEmailScreen(role: UserRole.sellerBeginner),
                        ),
                      );
                    },

                  ),

                  // 🟡 كارت Expert
                  buildTypeCard(
                    title: "Expert",
                    desc: "Verified professional seller",
                    features: [
                      "All Beginner features +",
                      "Verified Expert badge",
                      "Offer paid consultations",
                      "Featured in Top Sellers",
                      "Portfolio verification required",
                    ],
                    mainColor: const Color(0xFFC9A876),
                    leadingWidget: Image.asset(
                      "assets/images/key.png",
                      width: 24,
                      height: 24,
                    ),
                    elevated: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  CheckEmailScreen(role: UserRole.sellerExpert)
                        ),
                      );
                    },

                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
