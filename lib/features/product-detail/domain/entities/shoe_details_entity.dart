import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ShoeDetailsEntity {
  final int id;
  final String title;
  final double averageRating;
  final int reviewCount;
  final String description;
  final String imageUrl;
  final double salePrice;
  final List<Review> reviews;
  final List<ShoeVariations> shoeVariations;
  final ShoeVariations selectedShoe;

  ShoeDetailsEntity({
    required this.id,
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
    int? id,
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
    );
  }
}

class ShoeVariations {
  final int id;
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
}

class Review {
  final int id;
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
