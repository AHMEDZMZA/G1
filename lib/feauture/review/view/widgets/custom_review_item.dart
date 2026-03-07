import 'package:flutter/material.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';
import 'package:intl/intl.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String time;
  final String review;
  final double rating;

  const ReviewItem({
    super.key,
    required this.name,
    required this.time,
    required this.review,
    required this.rating,
  });
String formatDate(String time) {
  DateTime dateTime = DateTime.parse(time);
  return DateFormat('dd / MM / yyyy').format(dateTime);
}
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * .2,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF3E2723),
                  fontSize: 16,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                ),
              ),
              RatingStars(rating: rating),
            ],
          ),
          SizedBox(height: 4),
          Text(
             formatDate(time),
            style: TextStyle(
              color: const Color(0xFF8D6E63),
              fontSize: 14,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          Text(
            review,
            style: TextStyle(
              color: const Color(0xFF3E2723),
              fontSize: 16.5,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
