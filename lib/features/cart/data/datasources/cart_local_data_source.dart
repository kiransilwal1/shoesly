import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/cache_exceptions.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel> getCart();
  Future<void> addItem(CartItemModel cartItemModel);
  Future<void> removeItem(CartItemModel cartItemModel);
  Future<CartModel> swipeToRemove(CartItemModel cartItemModel);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addItem(CartItemModel cartItemModel) async {
    try {
      debugPrint("Adding item");
      final cart = await getCart();
      final updatedCartItems = List<CartItemModel>.from(cart.cartItems)
        ..add(cartItemModel);
      final updatedCart = CartModel(
          cartItems: updatedCartItems,
          totalCartPrice: cart.totalCartPrice + cartItemModel.totalItemPrice);
      await _saveCart(updatedCart);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<CartModel> getCart() async {
    final jsonString = sharedPreferences.getString(Constants.CACHED_CART);
    if (jsonString != null) {
      final String jsonMap = json.decode(jsonString);
      CartModel cart = CartModel.fromJson(jsonMap);
      return cart;
    } else {
      return CartModel.empty();
    }
  }

  @override
  Future<void> removeItem(CartItemModel cartItemModel) async {
    try {
      final cart = await getCart();
      final updatedCartItems = List<CartItemModel>.from(cart.cartItems)
        ..removeWhere((item) => item.id == cartItemModel.id);
      final updatedCart = CartModel(
          cartItems: updatedCartItems,
          totalCartPrice: cart.totalCartPrice - cartItemModel.totalItemPrice);
      await _saveCart(updatedCart);
    } catch (e) {
      throw CacheException('Failed to remove item from cart');
    }
  }

  @override
  Future<CartModel> swipeToRemove(CartItemModel cartItemModel) async {
    try {
      await removeItem(cartItemModel);
      return await getCart();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  Future<void> _saveCart(CartModel cartModel) async {
    final jsonString = json.encode(cartModel.toJson());
    sharedPreferences.setString(Constants.CACHED_CART, jsonString);
  }
}
