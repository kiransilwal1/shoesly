import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/entities/cart.dart';
import 'cart_item_model.dart';

class CartModel extends Cart {
  CartModel({required super.cartItems, required super.totalCartPrice});

  CartModel copyWith({
    List<CartItemModel>? cartItems,
    double? totalCartPrice,
  }) {
    return CartModel(
      cartItems: cartItems ?? this.cartItems,
      totalCartPrice: totalCartPrice ?? this.totalCartPrice,
    );
  }

  factory CartModel.empty() {
    return CartModel(cartItems: [], totalCartPrice: 0);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'totalCartPrice': totalCartPrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    debugPrint(map.toString());
    return CartModel(
      cartItems: List<CartItemModel>.from(
        (map['cartItems']).map<CartItemModel>(
          (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalCartPrice: map['totalCartPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Cart(cartItems: $cartItems, totalCartPrice: $totalCartPrice)';

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.cartItems, cartItems) &&
        other.totalCartPrice == totalCartPrice;
  }

  @override
  int get hashCode => cartItems.hashCode ^ totalCartPrice.hashCode;
}
