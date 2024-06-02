import 'dart:convert';

import '../../../product-detail/domain/entities/shoe_details_entity.dart';
import '../../domain/entities/cart_items.dart';

class CartItemModel extends CartItems {
  CartItemModel({
    required super.id,
    required super.variations,
    required super.quantity,
    required super.totalItemPrice,
  });

  CartItemModel copyWith({
    String? id,
    ShoeVariations? variations,
    int? quantity,
    double? totalItemPrice,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      variations: variations ?? this.variations,
      quantity: quantity ?? this.quantity,
      totalItemPrice: totalItemPrice ?? this.totalItemPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'variations': variations.toMap(),
      'quantity': quantity,
      'totalItemPrice': totalItemPrice,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      variations:
          ShoeVariations.fromMap(map['variations'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      totalItemPrice: map['totalItemPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItemModel(id: $id, variations: $variations, quantity: $quantity, totalItemPrice: $totalItemPrice)';
  }

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.variations == variations &&
        other.quantity == quantity &&
        other.totalItemPrice == totalItemPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        variations.hashCode ^
        quantity.hashCode ^
        totalItemPrice.hashCode;
  }
}
