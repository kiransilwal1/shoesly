// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shoesly/features/cart/data/models/cart_item_model.dart';

import 'cart_items.dart';

class Cart {
  final List<CartItemModel> cartItems;
  final double totalCartPrice;
  Cart({
    required this.cartItems,
    required this.totalCartPrice,
  });
}
