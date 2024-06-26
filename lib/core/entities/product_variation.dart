class ProductVariation {
  final String id;
  final String title;
  final String brandname;
  final String colorCode;
  final String colorName;
  final String image;
  final double size;
  final DateTime createdAt;
  final String productId;
  final double price;
  final String brandimage;
  ProductVariation({
    required this.id,
    required this.colorCode,
    required this.colorName,
    required this.image,
    required this.size,
    required this.createdAt,
    required this.productId,
    required this.price,
    required this.brandname,
    required this.title,
    required this.brandimage,
  });

  toJson() {}
}
