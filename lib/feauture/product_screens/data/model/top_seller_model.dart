class TopSellerModel {
  final String sellerId;
  final String name;
  final String? imageUrl;
  final String speciality;
  final double averageRating;
  final int reviewCount;

  TopSellerModel({
    required this.sellerId,
    required this.name,
    this.imageUrl,
    required this.speciality,
    required this.averageRating,
    required this.reviewCount,
  });

  factory TopSellerModel.fromJson(Map<String, dynamic> json) {
    return TopSellerModel(
      sellerId: json['sellerId']?.toString() ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'],
      speciality: json['speciality'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
    );
  }
}
