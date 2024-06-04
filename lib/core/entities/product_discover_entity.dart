class Product {
  final String id;
  final String title;
  final double averageRating;
  final double price;
  final int reviewCount;
  final String brandImageUrl;
  final String productImageUrl;
  final String brandId;
  final DateTime createdAt;
  Product({
    required this.id,
    required this.title,
    required this.averageRating,
    required this.price,
    required this.reviewCount,
    required this.brandImageUrl,
    required this.productImageUrl,
    required this.brandId,
    required this.createdAt,
  });
}
