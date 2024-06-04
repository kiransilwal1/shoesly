import 'package:shoesly/features/product_detail/domain/entities/product_entity.dart';
import 'package:shoesly/features/product_detail/domain/entities/product_review.dart';

import '../../../../core/entities/product_variation.dart';

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
