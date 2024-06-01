import 'package:shoesly/features/discover/domain/entities/filter_entity.dart';

class FilterModel extends FilterEntity {
  FilterModel({
    required super.brands,
    required super.minPrice,
    required super.maxPrice,
    required super.colorCodes,
  });
}
