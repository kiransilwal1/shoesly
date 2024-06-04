import 'package:shoesly/features/product_discover/domain/entities/color_entites.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';

import '../../../../core/entities/brands.dart';

class FilterEntity {
  final List<Brand> brands;
  final double minPrice;
  final double maxPrice;
  final List<ColorEntity> colorCodes;
  final ProductDataEntity stateData;
  final ProductDataEntity globalData;

  FilterEntity({
    required this.brands,
    required this.minPrice,
    required this.maxPrice,
    required this.colorCodes,
    required this.stateData,
    required this.globalData,
  });
}
