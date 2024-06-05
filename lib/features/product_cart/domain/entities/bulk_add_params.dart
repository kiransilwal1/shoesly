import '../../../../core/entities/product_variation.dart';

class BulkAddParams {
  final ProductVariation productVariation;
  final int count;

  BulkAddParams({required this.productVariation, required this.count});
}
