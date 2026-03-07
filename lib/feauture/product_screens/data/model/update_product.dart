class UpdateProductRequestModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final int price;
  final int quantity;
  final String description;
  final int categoryId;
  final String? imageFile;
  final List<String> tags;
  final String? sellerName;

  UpdateProductRequestModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.price,
    required this.quantity,
    required this.description,
    required this.categoryId,
    this.imageFile,
    required this.tags,
    this.sellerName,
  });
}