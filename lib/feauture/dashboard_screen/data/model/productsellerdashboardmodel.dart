class ProductsellerdashboardModel {
  final int id;
  final String name;
  final double price;
  final int stock;
  final String image;
  final String description;
  final int categoryId;
  final String? categoryName;

  ProductsellerdashboardModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.categoryName,
  });

  factory ProductsellerdashboardModel.fromJson(Map<String, dynamic> json) {
    return ProductsellerdashboardModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      price: (json['price'] ?? 0).toDouble(),
      stock: json['quantity'] ?? 0,
      image: json['imageUrl'] ?? "",
      description: json['description'] ?? "",
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',    );
  }
}
