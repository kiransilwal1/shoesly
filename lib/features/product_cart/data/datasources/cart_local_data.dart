import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesly/features/product_cart/data/models/product_variation_model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/cache_exceptions.dart';

import '../models/cart_model.dart';

abstract class ProductCartLocalData {
  Future<CartModel> addToCart(ProductVariationModel productModel);
  Future<CartModel> deleteFromCart(ProductVariationModel productModel);
  Future<CartModel> bulkAddToCart(
      {required ProductVariationModel productModel, required int quantity});
  Future<CartModel> bulkDeleteFromCart(
      {required ProductVariationModel productModel, required int quantity});
}

class ProductCartLocalDataImpl implements ProductCartLocalData {
  final SharedPreferences db;

  ProductCartLocalDataImpl(this.db);

  @override
  Future<CartModel> addToCart(ProductVariationModel productModel) async {
    try {
      final cart = await _getCart();
      cart.products.add(productModel);

      await _saveCart(cart);
      return cart;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<CartModel> deleteFromCart(ProductVariationModel productModel) async {
    try {
      final cart = await _getCart();
      cart.products.removeWhere((p) => p.id == productModel.id);

      await _saveCart(cart);
      return cart;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<CartModel> bulkAddToCart(
      {required ProductVariationModel productModel,
      required int quantity}) async {
    try {
      final cart = await _getCart();
      for (int i = 0; i < quantity; i++) {
        cart.products.add(productModel);
      }

      await _saveCart(cart);
      return cart;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<CartModel> bulkDeleteFromCart(
      {required ProductVariationModel productModel,
      required int quantity}) async {
    try {
      final cart = await _getCart();
      for (int i = 0; i < quantity; i++) {
        cart.products.remove(productModel);
      }

      await _saveCart(cart);
      return cart;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  Future<CartModel> _getCart() async {
    final jsonString = db.getString(Constants.CACHED_CART);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return CartModel.fromJson(jsonMap);
    } else {
      return CartModel(products: []);
    }
  }

  Future<void> _saveCart(CartModel cartModel) async {
    final jsonString = json.encode(cartModel.toJson());
    await db.setString(Constants.CACHED_CART, jsonString);
  }
}
