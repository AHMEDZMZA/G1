import 'package:flutter/material.dart';

class BuildRatingScreen extends StatefulWidget {
  const BuildRatingScreen({super.key, required this.onRatingChanged});
  final Function(int) onRatingChanged;
  @override
  State<BuildRatingScreen> createState() => _BuildRatingScreenState();
}

class _BuildRatingScreenState extends State<BuildRatingScreen> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: const Color(0xFF8B5E3C),
            size: 30,
          ),
          onPressed: () {
            setState(() {
              rating = index + 1;
            });

            // 👈 رجّع القيمة للـ parent
            widget.onRatingChanged(rating);
          },
        );
      }),
    );
  }
}
// import 'package:flutter/material.dart';

// class BuildRatingScreen extends StatefulWidget {
//   const BuildRatingScreen({super.key, required this.onRatingChanged});
//   final Function(double) onRatingChanged; // ممكن يبقى double علشان يدعم العشري

//   @override
//   State<BuildRatingScreen> createState() => _BuildRatingScreenState();
// }

// class _BuildRatingScreenState extends State<BuildRatingScreen> {
//   double rating = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(5, (index) {
//         Icon icon;
//         if (rating >= index + 1) {
//           icon = const Icon(Icons.star, color: Color(0xFF8B5E3C), size: 30);
//         } else if (rating > index && rating < index + 1) {
//           icon = const Icon(Icons.star_half, color: Color(0xFF8B5E3C), size: 30);
//         } else {
//           icon = const Icon(Icons.star_border, color: Color(0xFF8B5E3C), size: 30);
//         }

//         return IconButton(
//           padding: EdgeInsets.zero,
//           constraints: const BoxConstraints(),
//           icon: icon,
//           onPressed: () {
//             setState(() {
//               rating = index + 1; // ممكن تعدلي ده لو عايزة الضغط على نصف نجمة كمان
//             });

//             widget.onRatingChanged(rating);
//           },
//         );
//       }),
//     );
//   }
// }
