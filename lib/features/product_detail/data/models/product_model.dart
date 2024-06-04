import 'dart:convert';

import 'package:shoesly/features/product_detail/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.createdAt,
      required super.price,
      required super.image});

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    double? price,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'price': price,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.parse(map['created_at']),
      price: map['price'] as double,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, createdAt: $createdAt, price: $price, image: $image)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.price == price &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        price.hashCode ^
        image.hashCode;
  }
}
