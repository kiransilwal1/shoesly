import 'dart:convert';

import 'package:shoesly/features/product-detail/domain/entities/product_variations_enitity.dart';

class ProductVariationModel extends ProductVariationEntity {
  ProductVariationModel(
      {required super.id,
      required super.colorCode,
      required super.colorName,
      required super.image,
      required super.size,
      required super.createdAt,
      required super.productId});

  ProductVariationModel copyWith({
    String? id,
    String? colorCode,
    String? colorName,
    String? image,
    double? size,
    DateTime? createdAt,
    String? productId,
  }) {
    return ProductVariationModel(
      id: id ?? this.id,
      colorCode: colorCode ?? this.colorCode,
      colorName: colorName ?? this.colorName,
      image: image ?? this.image,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'colorCode': colorCode,
      'colorName': colorName,
      'image': image,
      'size': size,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'productId': productId,
    };
  }

  factory ProductVariationModel.fromMap(Map<String, dynamic> map) {
    return ProductVariationModel(
      id: map['id'] as String,
      colorCode: map['colorCode'] as String,
      colorName: map['colorName'] as String,
      image: map['image'] as String,
      size: map['size'] as double,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      productId: map['productId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVariationModel.fromJson(String source) =>
      ProductVariationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductVariationModel(id: $id, colorCode: $colorCode, colorName: $colorName, image: $image, size: $size, createdAt: $createdAt, productId: $productId)';
  }

  @override
  bool operator ==(covariant ProductVariationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.colorCode == colorCode &&
        other.colorName == colorName &&
        other.image == image &&
        other.size == size &&
        other.createdAt == createdAt &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        colorCode.hashCode ^
        colorName.hashCode ^
        image.hashCode ^
        size.hashCode ^
        createdAt.hashCode ^
        productId.hashCode;
  }
}
