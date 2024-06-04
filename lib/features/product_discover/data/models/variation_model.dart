import 'dart:convert';

import 'package:shoesly/features/product_discover/domain/entities/variation_entities.dart';

class VariationModel extends Variation {
  VariationModel(
      {required super.id,
      required super.colorcode,
      required super.colorname,
      required super.image,
      required super.size,
      required super.createdAt,
      required super.productId});

  VariationModel copyWith({
    String? id,
    String? colorcode,
    String? colorname,
    String? image,
    double? size,
    DateTime? createdAt,
    String? productId,
  }) {
    return VariationModel(
      id: id ?? this.id,
      colorcode: colorcode ?? this.colorcode,
      colorname: colorname ?? this.colorname,
      image: image ?? this.image,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'colorcode': colorcode,
      'colorname': colorname,
      'image': image,
      'size': size,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'productId': productId,
    };
  }

  factory VariationModel.fromMap(Map<String, dynamic> map) {
    return VariationModel(
      id: map['id'] as String,
      colorcode: map['colorcode'] as String,
      colorname: map['colorname'] as String,
      image: map['image'] as String,
      size: map['size'].toDouble() as double,
      createdAt: DateTime.parse(map['created_at']),
      productId: map['product_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariationModel.fromJson(String source) =>
      VariationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariationModel(id: $id, colorcode: $colorcode, colorname: $colorname, image: $image, size: $size, createdAt: $createdAt, productId: $productId)';
  }

  @override
  bool operator ==(covariant VariationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.colorcode == colorcode &&
        other.colorname == colorname &&
        other.image == image &&
        other.size == size &&
        other.createdAt == createdAt &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        colorcode.hashCode ^
        colorname.hashCode ^
        image.hashCode ^
        size.hashCode ^
        createdAt.hashCode ^
        productId.hashCode;
  }
}
