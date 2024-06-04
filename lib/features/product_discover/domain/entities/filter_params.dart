// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shoesly/features/product_discover/data/models/product_data_model.dart';

class FilterParams {
  final String? shoeBrand;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? gender;
  final String? color;
  final ProductDataModel stateData;
  final ProductDataModel globalData;
  FilterParams({
    this.shoeBrand,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
    this.gender,
    this.color,
    required this.stateData,
    required this.globalData,
  });
}
