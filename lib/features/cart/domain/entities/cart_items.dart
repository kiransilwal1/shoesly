// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../product-detail/domain/entities/shoe_details_entity.dart';

class CartItems {
  final String id;
  final ShoeVariations variations;
  final int quantity;
  final double totalItemPrice;
  CartItems({
    required this.id,
    required this.variations,
    required this.quantity,
    required this.totalItemPrice,
  });
}
