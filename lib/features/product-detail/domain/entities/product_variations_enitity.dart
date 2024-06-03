// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductVariationEntity {
  final String id;
  final String colorCode;
  final String colorName;
  final String image;
  final double size;
  final DateTime createdAt;
  final String productId;
  ProductVariationEntity({
    required this.id,
    required this.colorCode,
    required this.colorName,
    required this.image,
    required this.size,
    required this.createdAt,
    required this.productId,
  });
}
