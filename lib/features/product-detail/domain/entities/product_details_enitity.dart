import 'package:shoesly/core/entities/product_discover_entity.dart';

import 'package:shoesly/features/product-detail/domain/entities/product_variations_enitity.dart';

class ProductDetailWithVariations {
  final Product products;
  final List<ProductVariationEntity> productVariations;
  ProductDetailWithVariations({
    required this.products,
    required this.productVariations,
  });
}
