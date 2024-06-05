import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/models/product_variation_model.dart';
import '../../../../core/models/cart_model.dart';

abstract interface class ProductCartLocalData {
  Future<CartModel> addToCart(ProductVariationModel productModel);
  Future<CartModel> deleteFromCart(ProductVariationModel productModel);
  Future<CartModel> bulkAddToCart(
      {required ProductVariationModel productModel, required int quantity});
  Future<CartModel> bulkDeleteFromCart(
      {required ProductVariationModel productModel});
  Future<CartModel> getCart();
}

class ProductCartLocalDataImpl implements ProductCartLocalData {
  final SharedPreferences db;

  ProductCartLocalDataImpl({required this.db});

  @override
  Future<CartModel> addToCart(ProductVariationModel productModel) async {
    try {
      final cart = await getCart();
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
      final cart = await getCart();
      int index = cart.products.indexWhere((p) => p.id == productModel.id);
      if (index != -1) {
        cart.products.removeAt(index);
      }
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
      final cart = await getCart();
      //TODO: Do while loop to handle the case where i = 1;
      int i = 0;
      do {
        cart.products.add(productModel);
        i++;
      } while (i < quantity);

      await _saveCart(cart);
      return cart;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<CartModel> bulkDeleteFromCart(
      {required ProductVariationModel productModel}) async {
    try {
      final cart = await getCart();
      cart.products.removeWhere((p) => p.id == productModel.id);

      await _saveCart(cart);
      return cart;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<CartModel> getCart() async {
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
