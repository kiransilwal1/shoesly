import 'dart:convert';

import 'package:shoesly/features/product_detail_v2/domain/entities/product_review.dart';

class ProductReviewModel extends ProductReview {
  ProductReviewModel(
      {required super.id,
      required super.imageUrl,
      required super.userName,
      required super.userRating,
      required super.userDescription,
      required super.createdAt});

  ProductReviewModel copyWith({
    String? id,
    String? imageUrl,
    String? userName,
    int? userRating,
    String? userDescription,
    DateTime? createdAt,
  }) {
    return ProductReviewModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      userName: userName ?? this.userName,
      userRating: userRating ?? this.userRating,
      userDescription: userDescription ?? this.userDescription,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'userName': userName,
      'userRating': userRating,
      'userDescription': userDescription,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ProductReviewModel.fromMap(Map<String, dynamic> map) {
    return ProductReviewModel(
      id: map['id'] as String,
      imageUrl: map['product_user']['photourl'] as String,
      userName: map['product_user']['name'] as String,
      userRating: map['rating'] as int,
      userDescription: map['comment'] as String,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductReviewModel.fromJson(String source) =>
      ProductReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductReviewModel(id: $id, imageUrl: $imageUrl, userName: $userName, userRating: $userRating, userDescription: $userDescription, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ProductReviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imageUrl == imageUrl &&
        other.userName == userName &&
        other.userRating == userRating &&
        other.userDescription == userDescription &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        userName.hashCode ^
        userRating.hashCode ^
        userDescription.hashCode ^
        createdAt.hashCode;
  }
}
