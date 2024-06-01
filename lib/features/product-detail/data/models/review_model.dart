import 'dart:convert';

import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

class ReviewModel extends Review {
  ReviewModel(
      {required super.id,
      required super.imageUrl,
      required super.userName,
      required super.userRating,
      required super.userDescription});

  Review copyWith({
    int? id,
    String? imageUrl,
    String? userName,
    int? userRating,
    String? userDescription,
  }) {
    return Review(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      userName: userName ?? this.userName,
      userRating: userRating ?? this.userRating,
      userDescription: userDescription ?? this.userDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'userName': userName,
      'userRating': userRating,
      'userDescription': userDescription,
    };
  }

//TODO: User image is fetched from database, since there are no images populated in the database the implicit value will be null.

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] as int,
      imageUrl: map['imageUrl'] ??
          'https://firebasestorage.googleapis.com/v0/b/shoesly-54cf7.appspot.com/o/ussopprofile.jpeg?alt=media&token=172f804d-c41e-4a54-bc4a-3f37bf8b50b8',
      userName: map['name'] as String,
      userRating: map['rating'],
      userDescription: map['comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, imageUrl: $imageUrl, userName: $userName, userRating: $userRating, userDescription: $userDescription)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imageUrl == imageUrl &&
        other.userName == userName &&
        other.userRating == userRating &&
        other.userDescription == userDescription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        userName.hashCode ^
        userRating.hashCode ^
        userDescription.hashCode;
  }
}
