import 'package:shoesly/features/product_detail_v2/domain/entities/product_entity.dart';
import 'package:shoesly/features/product_detail_v2/domain/entities/product_review.dart';

import 'product_variation.dart';

class ProductDetailEntity {
  final ProductEntity product;
  final List<ProductVariation> productVariations;
  final List<ProductReview> productReveiws;
  ProductDetailEntity({
    required this.product,
    required this.productVariations,
    required this.productReveiws,
  });
}
