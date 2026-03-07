class ProductStatsModel {
  final int totalReviews;
  final double averageRating;

  ProductStatsModel({
    required this.totalReviews,
    required this.averageRating,
  });

  factory ProductStatsModel.fromJson(Map<String, dynamic> json) {
    return ProductStatsModel(
      totalReviews: json['totalReviews'] ?? 0,
      averageRating: (json['averageRating'] ?? 0).toDouble(),
    );
  }
}

