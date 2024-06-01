import 'dart:convert';

import '../../domain/entities/brands.dart';

class BrandModel extends Brand {
  BrandModel(
      {required super.brandName,
      required super.image,
      required super.id,
      required super.count});

  BrandModel copyWith({
    String? brandName,
    int? count,
    String? image,
    String? id,
  }) {
    return BrandModel(
      brandName: brandName ?? this.brandName,
      count: count ?? this.count,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brandName': brandName,
      'count': count,
      'image': image,
      'id': id,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      brandName: map['brand_id'] as String,
      count: map['item_count'] as int,
      image: map['brand_image_url'] as String,
      id: map['brand_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Brand(brandName: $brandName, count: $count, image: $image, id: $id)';
  }

  @override
  bool operator ==(covariant BrandModel other) {
    if (identical(this, other)) return true;

    return other.brandName == brandName &&
        other.count == count &&
        other.image == image &&
        other.id == id;
  }

  @override
  int get hashCode {
    return brandName.hashCode ^ count.hashCode ^ image.hashCode ^ id.hashCode;
  }
}
