import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shoesly/features/product_detail_v2/data/models/product_review_mode.dart';
import 'package:shoesly/features/product_detail_v2/domain/entities/product_detail_entity.dart';

import 'product_model.dart';
import 'product_variation_model.dart';

class ProductDetailModel extends ProductDetailEntity {
  ProductDetailModel(
      {required super.product,
      required super.productVariations,
      required super.productReveiws});

  ProductDetailModel copyWith({
    ProductModel? product,
    List<ProductVariationModel>? productVariations,
    List<ProductReviewModel>? productReveiws,
  }) {
    return ProductDetailModel(
      product: product ?? this.product as ProductModel,
      productVariations: productVariations ?? this.productVariations,
      productReveiws: productReveiws ?? this.productReveiws,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': (product as ProductModel).toMap(),
      'productVariations': (productVariations as List<ProductVariationModel>)
          .map((x) => x.toMap())
          .toList(),
      'productReveiws': (productReveiws as List<ProductReviewModel>)
          .map((x) => x.toMap())
          .toList(),
    };
  }

  factory ProductDetailModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailModel(
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
      productVariations: List<ProductVariationModel>.from(
        (map['productVariations'] as List<int>).map<ProductVariationModel>(
          (x) => ProductVariationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      productReveiws: List<ProductReviewModel>.from(
        (map['productReveiws'] as List<int>).map<ProductReviewModel>(
          (x) => ProductReviewModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailModel.fromJson(String source) =>
      ProductDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductDetailModel(product: $product, productVariations: $productVariations, productReveiws: $productReveiws)';

  @override
  bool operator ==(covariant ProductDetailModel other) {
    if (identical(this, other)) return true;

    return other.product == product &&
        listEquals(other.productVariations, productVariations) &&
        listEquals(other.productReveiws, productReveiws);
  }

  @override
  int get hashCode =>
      product.hashCode ^ productVariations.hashCode ^ productReveiws.hashCode;
}
