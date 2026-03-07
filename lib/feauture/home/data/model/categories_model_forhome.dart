class CategoriesModel {
  final int ?id;
  final String name;
  final String imageUrl;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['Id'] ?? json['id'],
      name: json['Name'] ?? json['name'] ?? '',
      imageUrl: json['image'] ?? json['Image'] ?? '',
    );
  }
}
