import 'product_discover_entity.dart';

class ProductVariations extends Product {
  ProductVariations(
      {required super.id,
      required super.title,
      required super.averageRating,
      required super.price,
      required super.reviewCount,
      required super.brandImageUrl,
      required super.productImageUrl,
      required this.variationImageUrl,
      required this.availableSizes,
      required this.availableColors,
      required this.variationId});
  final String variationId;
  final String variationImageUrl;
  final List<double> availableSizes;
  final List<String> availableColors;
}
