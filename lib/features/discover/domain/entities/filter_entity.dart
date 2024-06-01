import 'package:shoesly/features/discover/domain/entities/color_entites.dart';

import 'brands.dart';

class FilterEntity {
  final List<Brand> brands;
  final double minPrice;
  final double maxPrice;
  final List<ColorEntity> colorCodes;

  FilterEntity(
      {required this.brands,
      required this.minPrice,
      required this.maxPrice,
      required this.colorCodes});
}
