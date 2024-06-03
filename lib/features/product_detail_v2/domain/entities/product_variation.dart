class ProductVariation {
  final String id;
  final String colorCode;
  final String colorName;
  final String image;
  final double size;
  final DateTime createdAt;
  final String productId;
  ProductVariation({
    required this.id,
    required this.colorCode,
    required this.colorName,
    required this.image,
    required this.size,
    required this.createdAt,
    required this.productId,
  });
}
