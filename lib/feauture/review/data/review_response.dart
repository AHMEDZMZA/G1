class ReviewResponse {
  final int interactionId;
  final String reviewerId;
  final String reviewerName;
  final int rating;
  final String reviewComment;
  final DateTime createdAt;

  ReviewResponse({
    required this.interactionId,
    required this.reviewerId,
    required this.reviewerName,
    required this.rating,
    required this.reviewComment,
    required this.createdAt,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      interactionId: json['interactionId'],
      reviewerId: json['reviewerId'],
      reviewerName: json['reviewerName'],
      rating: json['rating'],
      reviewComment: json['reviewComment'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
