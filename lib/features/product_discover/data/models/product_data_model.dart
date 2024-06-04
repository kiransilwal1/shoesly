import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/models/brand_model.dart';
import '../../../../core/models/product_model.dart';
import '../../domain/entities/product_data_entity.dart';
import 'variation_model.dart';

class ProductDataModel extends ProductDataEntity {
  ProductDataModel(
      {required super.products,
      required super.brands,
      required super.productVariations});

  ProductDataModel copyWith({
    List<ProductModel>? products,
    List<BrandModel>? brands,
    List<VariationModel>? productVariations,
  }) {
    return ProductDataModel(
      products: products ?? this.products,
      brands: brands ?? this.brands,
      productVariations: productVariations ?? this.productVariations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'brands': brands.map((x) => x.toMap()).toList(),
      'productVariations': productVariations.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      brands: List<BrandModel>.from(
        (map['brands'] as List<int>).map<BrandModel>(
          (x) => BrandModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      productVariations: List<VariationModel>.from(
        (map['productVariations'] as List<int>).map<VariationModel>(
          (x) => VariationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDataModel.fromJson(String source) =>
      ProductDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductDataModel(products: $products, brands: $brands, productVariations: $productVariations)';

  @override
  bool operator ==(covariant ProductDataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products) &&
        listEquals(other.brands, brands) &&
        listEquals(other.productVariations, productVariations);
  }

  @override
  int get hashCode =>
      products.hashCode ^ brands.hashCode ^ productVariations.hashCode;
}
