class ProductReviewModel {
  final String reviewerName;
  final int rating;
  final String review;
  final dynamic createdAt;
  ProductReviewModel({
    required this.reviewerName,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      reviewerName: json['reviewerName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      rating: json['rating'] ?? 0,
      review: json['reviewComment'] ?? '',
    );
  }
}
