import 'dart:convert';

import '../entities/product_discover_entity.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.id,
      required super.title,
      required super.averageRating,
      required super.price,
      required super.reviewCount,
      required super.brandImageUrl,
      required super.productImageUrl,
      required super.brandId,
      required super.createdAt});

  Product copyWith({
    String? id,
    String? title,
    double? averageRating,
    double? price,
    int? reviewCount,
    String? brandImageUrl,
    String? productImageUrl,
    DateTime? createdAt,
    String? brandId,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      averageRating: averageRating ?? this.averageRating,
      price: price ?? this.price,
      reviewCount: reviewCount ?? this.reviewCount,
      brandImageUrl: brandImageUrl ?? this.brandImageUrl,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      brandId: brandId ?? this.brandId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'averageRating': averageRating,
      'price': price,
      'reviewCount': reviewCount,
      'brandImageUrl': brandImageUrl,
      'productImageUrl': productImageUrl,
      'brand_id': brandId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      averageRating: map['average_rating'].toDouble() as double,
      price: map['price'] as double,
      reviewCount: map['review_count'] as int,
      brandImageUrl: map['brand_image_url'] as String,
      productImageUrl: map['product_url'] as String,
      brandId: map['brand_id'] as String,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, averageRating: $averageRating, price: $price, reviewCount: $reviewCount, brandImageUrl: $brandImageUrl, productImageUrl: $productImageUrl brandId:$brandId,created_at:$createdAt)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.averageRating == averageRating &&
        other.price == price &&
        other.reviewCount == reviewCount &&
        other.brandImageUrl == brandImageUrl &&
        other.brandId == brandId &&
        other.createdAt == createdAt &&
        other.productImageUrl == productImageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        averageRating.hashCode ^
        price.hashCode ^
        reviewCount.hashCode ^
        brandImageUrl.hashCode ^
        brandId.hashCode ^
        createdAt.hashCode ^
        productImageUrl.hashCode;
  }
}
