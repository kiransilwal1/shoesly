import '../../../../core/entities/product_discover_entity.dart';

class ProductVariationModel extends Product {
  final String variationId;
  final String variationImageUrl;
  final List<double> availableSizes;
  final List<String> availableColors;

  ProductVariationModel({
    required String id,
    required String title,
    required double averageRating,
    required double price,
    required int reviewCount,
    required String brandImageUrl,
    required String productImageUrl,
    required this.variationImageUrl,
    required this.availableSizes,
    required this.availableColors,
    required this.variationId,
  }) : super(
          id: id,
          title: title,
          averageRating: averageRating,
          price: price,
          reviewCount: reviewCount,
          brandImageUrl: brandImageUrl,
          productImageUrl: productImageUrl,
        );

  ProductVariationModel copyWith({
    String? id,
    String? title,
    double? averageRating,
    double? price,
    int? reviewCount,
    String? brandImageUrl,
    String? productImageUrl,
    String? variationImageUrl,
    List<double>? availableSizes,
    List<String>? availableColors,
    String? variationId,
  }) {
    return ProductVariationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      averageRating: averageRating ?? this.averageRating,
      price: price ?? this.price,
      reviewCount: reviewCount ?? this.reviewCount,
      brandImageUrl: brandImageUrl ?? this.brandImageUrl,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      variationImageUrl: variationImageUrl ?? this.variationImageUrl,
      availableSizes: availableSizes ?? this.availableSizes,
      availableColors: availableColors ?? this.availableColors,
      variationId: variationId ?? this.variationId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'averageRating': averageRating,
      'price': price,
      'reviewCount': reviewCount,
      'brandImageUrl': brandImageUrl,
      'productImageUrl': productImageUrl,
      'variationImageUrl': variationImageUrl,
      'availableSizes': availableSizes,
      'availableColors': availableColors,
      'variationId': variationId,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'],
      title: json['title'],
      averageRating: json['averageRating'],
      price: json['price'],
      reviewCount: json['reviewCount'],
      brandImageUrl: json['brandImageUrl'],
      productImageUrl: json['productImageUrl'],
      variationImageUrl: json['variationImageUrl'],
      availableSizes: List<double>.from(json['availableSizes']),
      availableColors: List<String>.from(json['availableColors']),
      variationId: json['variationId'],
    );
  }
}
