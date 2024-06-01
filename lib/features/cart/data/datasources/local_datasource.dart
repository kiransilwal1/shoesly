import 'dart:async';

import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

import '../../../discover/domain/entities/shoes.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Stream<CartModel> getCart();
  Future<void> addToCart(ShoeVariations shoe);
  Future<void> removeFromCart(ShoeVariations shoe);
}

class CartDataSourceImpl implements CartLocalDataSource {
  final _cartController = StreamController<CartModel>.broadcast();
  final List<ShoeVariations> _items = [];
  @override
  Stream<CartModel> getCart() => _cartController.stream;

  @override
  Future<void> addToCart(ShoeVariations shoe) async {
    _items.add(shoe);
    _cartController.add(CartModel(items: List.from(_items)));
  }

  @override
  Future<void> removeFromCart(ShoeVariations shoe) async {
    _items.remove(shoe);
    _cartController.add(CartModel(items: List.from(_items)));
  }
}
