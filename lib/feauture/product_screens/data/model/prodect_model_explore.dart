class ProductsModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final double rating;

  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    this.rating = 0,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      // تأكدي أن الأسماء (Keys) تطابق ما يرسله الـ API بالضبط
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      description: json['description'] ?? '',

      // تحويل السعر بأمان سواء كان int أو double
      price: (json['price'] ?? 0).toDouble(),

      // التأكد من اسم حقل الصورة (قد يكون imageUrl أو image_url)
      imageUrl: json['imageUrl'] ?? json['image_url'],

      // معالجة التقييم بأمان ليتوافق مع الـ UI
      rating: json['rating'] != null ? (json['rating']).toDouble() : 4.5,
    );
  }
}
