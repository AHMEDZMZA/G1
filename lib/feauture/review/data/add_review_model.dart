class AddReviewRequest {
  final int? productId;
  final int rating;
  final String? review;

  AddReviewRequest({this.productId, required this.rating, this.review});

  Map<String, dynamic> toJson() {
    return {
      if (productId != null) 'productId': productId,
      'rating': rating,
      if (review != null && review!.isNotEmpty) 'review': review,
    };
  }
}
