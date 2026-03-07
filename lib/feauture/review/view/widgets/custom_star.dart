// import 'package:flutter/material.dart';

// class RatingStars extends StatelessWidget {
//   final int rating;
//   final double size;

//   const RatingStars({super.key, required this.rating, this.size = 16});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(
//         5,
//         (index) => Icon(
//           Icons.star,
//           size: size,
//           color: index < rating ? Color(0xffC9A875) : Colors.grey.shade300,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index + 1 <= rating) {
          // نجمة كاملة
          return Icon(Icons.star, size: size, color: const Color(0xffC9A875));
        } else if (index < rating && index + 1 > rating) {
          // نجمة نص
          return Icon(Icons.star_half,
              size: size, color: const Color(0xffC9A875));
        } else {
          // نجمة فاضية
          return Icon(Icons.star,
              size: size, color: Colors.grey.shade300);
        }
      }),
    );
  }
}