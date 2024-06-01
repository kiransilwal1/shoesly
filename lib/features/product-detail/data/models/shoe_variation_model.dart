import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

class ShoeVariationModel extends ShoeVariations {
  ShoeVariationModel(
      {required super.id,
      required super.colorCode,
      required super.size,
      required super.imageUrl});

  ShoeVariationModel copyWith({
    int? id,
    String? colorCode,
    double? size,
    String? imageUrl,
  }) {
    return ShoeVariationModel(
      id: id ?? this.id,
      colorCode: colorCode ?? this.colorCode,
      size: size ?? this.size,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'colorCode': colorCode,
      'size': size,
      'imageUrl': imageUrl,
    };
  }

  factory ShoeVariationModel.fromMap(Map<String, dynamic> map) {
    debugPrint(map.toString());
    return ShoeVariationModel(
      id: map['id'] as int,
      colorCode: map['colorcode'] as String,
      size: map['size'] as double,
      imageUrl: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoeVariationModel.fromJson(String source) =>
      ShoeVariationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShoeVariationModel(id: $id, colorCode: $colorCode, size: $size, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant ShoeVariationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.colorCode == colorCode &&
        other.size == size &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ colorCode.hashCode ^ size.hashCode ^ imageUrl.hashCode;
  }
}
