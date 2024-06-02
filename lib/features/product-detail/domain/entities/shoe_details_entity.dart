// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class ShoeDetailsEntity {
  final String id;
  final String title;
  final double averageRating;
  final int reviewCount;
  final String description;
  final String imageUrl;
  final double salePrice;
  final String brandName;
  final List<Review> reviews;
  final List<ShoeVariations> shoeVariations;
  final ShoeVariations selectedShoe;

  ShoeDetailsEntity({
    required this.id,
    required this.brandName,
    required this.title,
    required this.averageRating,
    required this.salePrice,
    required this.imageUrl,
    required this.reviewCount,
    required this.description,
    required this.reviews,
    required this.shoeVariations,
    required this.selectedShoe,
  });

  ShoeDetailsEntity copyWith({
    String? id,
    String? title,
    double? averageRating,
    int? reviewCount,
    String? description,
    String? imageUrl,
    double? salePrice,
    List<Review>? reviews,
    List<ShoeVariations>? shoeVariations,
    ShoeVariations? selectedShoe,
  }) {
    return ShoeDetailsEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      salePrice: salePrice ?? this.salePrice,
      reviews: reviews ?? this.reviews,
      shoeVariations: shoeVariations ?? this.shoeVariations,
      selectedShoe: selectedShoe ?? this.selectedShoe,
      brandName: '',
    );
  }
}

class ShoeVariations {
  final String id;
  final String colorCode;
  final double size;
  final String imageUrl;
  final String colorName;
  final double salePrice;
  final String description;
  final double price;
  ShoeVariations({
    required this.id,
    required this.colorCode,
    required this.size,
    required this.imageUrl,
    required this.colorName,
    required this.salePrice,
    required this.description,
    required this.price,
  });

  ShoeVariations copyWith({
    String? id,
    String? colorCode,
    double? size,
    String? imageUrl,
    String? colorName,
    double? salePrice,
    String? description,
    double? price,
  }) {
    return ShoeVariations(
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

  factory ShoeVariations.fromMap(Map<String, dynamic> map) {
    return ShoeVariations(
      id: map['id'] as String,
      colorCode: map['colorCode'] as String,
      size: map['size'] as double,
      imageUrl: map['imageUrl'] as String,
      colorName: map['colorName'] as String,
      salePrice: map['salePrice'] as double,
      description: map['description'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoeVariations.fromJson(String source) =>
      ShoeVariations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShoeVariations(id: $id, colorCode: $colorCode, size: $size, imageUrl: $imageUrl, colorName: $colorName, salePrice: $salePrice, description: $description, price: $price)';
  }

  @override
  bool operator ==(covariant ShoeVariations other) {
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

class Review {
  final String id;
  final String imageUrl;
  final String userName;
  final int userRating;
  final String userDescription;
  Review({
    required this.id,
    required this.imageUrl,
    required this.userName,
    required this.userRating,
    required this.userDescription,
  });
}
