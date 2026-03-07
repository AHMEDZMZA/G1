import 'package:flutter/material.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/product_screens/data/model/prodect_model_explore.dart';
import 'package:graduation2/feauture/review/data/product_review_model.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_review_item.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';
import 'package:graduation2/feauture/review/view/write_review.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, required this.idProduct});
  final int idProduct;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  bool isLoading = true;
  List<ProductReviewModel> reviews = [];
  final ReviewApiService _reviewApiService = ReviewApiService();
  @override
  void initState() {
    super.initState();
    fetchReviews();
    _loadProductStats();
  }

  double averageRating = 0.0;
  int totalReviews = 0;
  bool isLoadingRating = true;

  Future<void> _loadProductStats() async {
    final stats = await _reviewApiService.getProductStats(widget.idProduct);

    if (stats != null) {
      setState(() {
        averageRating = stats.averageRating;
        totalReviews = stats.totalReviews;
        isLoadingRating = false;
      });
    }
  }

  Future<void> fetchReviews() async {
    try {
      final result = await _reviewApiService.getProductReviews(
        widget.idProduct,
      );

      setState(() {
        reviews = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
        title: Text(
          'Reviews & Ratings',
          style: TextStyle(color: Color(0xff3E2723)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                height: height * .1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            isLoadingRating
                                ? const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    ' ${averageRating.toStringAsFixed(1)} ',
                                    style: const TextStyle(
                                      color: Color(0xFF3E2723),
                                      fontSize: 14.5,
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                            SizedBox(width: width * .025),
                            RatingStars(rating: averageRating),
                            // Icon(Icons.star, color: Color(0xffC9A875)),
                            // Icon(Icons.star, color: Color(0xffC9A875)),
                            // Icon(Icons.star, color: Color(0xffC9A875)),
                            // Icon(Icons.star, color: Color(0xffC9A875)),
                            // Icon(Icons.star, color: Color(0xffC9A875)),
                          ],
                        ),
                        SizedBox(height: height * .015),
                        Text(
                          'Based on ${totalReviews} reviews',
                          style: TextStyle(
                            color: const Color(0xFF8D6E63),
                            fontSize: 16,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width * .35,
                      height: height * .05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                          begin: Alignment(0.50, 0.00),
                          end: Alignment(0.50, 1.00),
                          colors: [
                            const Color(0xFF6D4C41),
                            const Color(0xFF8D6E63),
                          ],
                        ),
                      ),
                      child: GestureDetector(
                        child: Center(
                          child: Text(
                            'Write Review',
                            style: TextStyle(
                              color: const Color(0xFFFAF8F5),
                              fontSize: 16,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  WriteReviewScreen(productId: widget.idProduct),
                            ),
                          ).then((_) => fetchReviews());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .01),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : reviews.isEmpty
                  ? Center(child: Text("No reviews yet"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return ReviewItem(
                          name: review.reviewerName,
                          time: review.createdAt, // لو مش موجود من API
                          review: review.review,
                          rating: review.rating.toDouble(),
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
