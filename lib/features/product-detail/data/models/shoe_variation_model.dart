import 'dart:convert';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

class ShoeVariationModel extends ShoeVariations {
  ShoeVariationModel(
      {required super.id,
      required super.colorCode,
      required super.size,
      required super.imageUrl,
      required super.colorName,
      required super.salePrice,
      required super.description,
      required super.price});

  ShoeVariationModel copyWith({
    int? id,
    String? colorCode,
    double? size,
    String? imageUrl,
    String? colorName,
    double? salePrice,
    String? description,
    double? price,
  }) {
    return ShoeVariationModel(
      id: id ?? this.id,
      colorCode: colorCode ?? this.colorCode,
      size: size ?? this.size,
      imageUrl: imageUrl ?? this.imageUrl,
      colorName: colorName ?? this.colorName,
      salePrice: salePrice ?? this.salePrice,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'colorCode': colorCode,
      'size': size,
      'imageUrl': imageUrl,
      'colorName': colorName,
      'salePrice': salePrice,
      'description': description,
      'price': price,
    };
  }

  factory ShoeVariationModel.fromMap(Map<String, dynamic> map) {
    return ShoeVariationModel(
      id: map['id'] as int,
      colorCode: map['colorcode'] as String,
      size: map['size'] as double,
      imageUrl: map['image'] as String,
      colorName: map['colorname'] as String,
      salePrice: map['saleprice'] as double,
      description: map['description'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoeVariationModel.fromJson(String source) =>
      ShoeVariationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShoeVariationModel(id: $id, colorCode: $colorCode, size: $size, imageUrl: $imageUrl, colorName: $colorName, salePrice: $salePrice, description: $description, price: $price)';
  }

  @override
  bool operator ==(covariant ShoeVariationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.colorCode == colorCode &&
        other.size == size &&
        other.imageUrl == imageUrl &&
        other.colorName == colorName &&
        other.salePrice == salePrice &&
        other.description == description &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        colorCode.hashCode ^
        size.hashCode ^
        imageUrl.hashCode ^
        colorName.hashCode ^
        salePrice.hashCode ^
        description.hashCode ^
        price.hashCode;
  }
}
