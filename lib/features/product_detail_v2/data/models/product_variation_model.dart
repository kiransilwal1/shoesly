import 'dart:convert';

import '../../domain/entities/product_variation.dart';

class ProductVariationModel extends ProductVariation {
  ProductVariationModel(
      {required super.id,
      required super.colorCode,
      required super.colorName,
      required super.image,
      required super.size,
      required super.createdAt,
      required super.price,
      required super.productId});

  ProductVariationModel copyWith({
    String? id,
    String? colorCode,
    String? colorName,
    String? image,
    double? size,
    DateTime? createdAt,
    double? price,
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
      price: price ?? this.price,
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
      colorCode: map['colorcode'] as String,
      colorName: map['colorname'] as String,
      image: map['image'] as String,
      size: map['size'].toDouble() as double,
      createdAt: DateTime.parse(map['created_at']),
      productId: map['product_id'] as String,
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVariationModel.fromJson(String source) =>
      ProductVariationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductVariationModel(id: $id, colorCode: $colorCode, colorName: $colorName, image: $image, size: $size, createdAt: $createdAt, productId: $productId,price: $price)';
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
        other.price == price &&
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
        price.hashCode ^
        productId.hashCode;
  }
}