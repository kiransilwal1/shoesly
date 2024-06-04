import 'dart:convert';

import 'package:shoesly/features/product_discover/data/models/product_data_model.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_params.dart';

class FilterParamModel extends FilterParams {
  FilterParamModel(
      {required super.shoeBrand,
      required super.minPrice,
      required super.maxPrice,
      required super.sortBy,
      required super.gender,
      required super.color,
      required super.stateData,
      required super.globalData});

  FilterParamModel copyWith({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
    ProductDataModel? stateData,
    ProductDataModel? globalData,
  }) {
    return FilterParamModel(
      shoeBrand: shoeBrand ?? this.shoeBrand,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
      gender: gender ?? this.gender,
      color: color ?? this.color,
      stateData: stateData ?? this.stateData,
      globalData: globalData ?? this.globalData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shoeBrand': shoeBrand,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'sortBy': sortBy,
      'gender': gender,
      'color': color,
      'stateData': stateData.toMap(),
      'globalData': globalData.toMap(),
    };
  }

  factory FilterParamModel.fromMap(Map<String, dynamic> map) {
    return FilterParamModel(
      shoeBrand: map['shoeBrand'] != null ? map['shoeBrand'] as String : null,
      minPrice: map['minPrice'] != null ? map['minPrice'] as double : null,
      maxPrice: map['maxPrice'] != null ? map['maxPrice'] as double : null,
      sortBy: map['sortBy'] != null ? map['sortBy'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      stateData:
          ProductDataModel.fromMap(map['stateData'] as Map<String, dynamic>),
      globalData:
          ProductDataModel.fromMap(map['globalData'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterParamModel.fromJson(String source) =>
      FilterParamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FilterParamModel(shoeBrand: $shoeBrand, minPrice: $minPrice, maxPrice: $maxPrice, sortBy: $sortBy, gender: $gender, color: $color, stateData: $stateData, globalData: $globalData)';
  }

  @override
  bool operator ==(covariant FilterParamModel other) {
    if (identical(this, other)) return true;

    return other.shoeBrand == shoeBrand &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice &&
        other.sortBy == sortBy &&
        other.gender == gender &&
        other.color == color &&
        other.stateData == stateData &&
        other.globalData == globalData;
  }

  @override
  int get hashCode {
    return shoeBrand.hashCode ^
        minPrice.hashCode ^
        maxPrice.hashCode ^
        sortBy.hashCode ^
        gender.hashCode ^
        color.hashCode ^
        stateData.hashCode ^
        globalData.hashCode;
  }
}
