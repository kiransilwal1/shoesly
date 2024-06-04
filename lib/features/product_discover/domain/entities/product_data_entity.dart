import 'package:shoesly/core/models/brand_model.dart';
import 'package:shoesly/features/product_discover/data/models/variation_model.dart';

import '../../../../core/models/product_model.dart';

class ProductDataEntity {
  final List<ProductModel> products;
  final List<BrandModel> brands;
  final List<VariationModel> productVariations;
  ProductDataEntity({
    required this.products,
    required this.brands,
    required this.productVariations,
  });
}
