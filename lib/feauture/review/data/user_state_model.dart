class UserStateModel {
  final int totalReviews;
  final double averageRating;

  UserStateModel({required this.totalReviews, required this.averageRating});

  factory UserStateModel.fromJson(Map<String, dynamic> json) {
    return UserStateModel(
      totalReviews: json['totalReviews'] ?? 0,
      averageRating: (json['averageRating'] ?? 0).toDouble(),
    );
  }
}
