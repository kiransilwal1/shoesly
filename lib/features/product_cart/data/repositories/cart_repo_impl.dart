import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/exceptions.dart';

import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_cart/data/datasources/cart_local_data.dart';
import 'package:shoesly/features/product_cart/domain/entities/cart.dart';

import '../../../../core/models/product_variation_model.dart';
import '../../domain/repositories/cart_repo.dart';

class ProductCartRepoImpl implements ProductCartRepo {
  final ProductCartLocalData cartLocalData;

  ProductCartRepoImpl({required this.cartLocalData});

  @override
  Future<Either<Failure, Cart>> addToCart({
    required String id,
    required String colorCode,
    required String colorName,
    required String image,
    required double size,
    required DateTime createdAt,
    required String productId,
    required double price,
    required String brandname,
    required String title,
    required String brandImageUrl,
  }) async {
    try {
      ProductVariationModel productModel = ProductVariationModel(
        id: id,
        colorCode: colorCode,
        colorName: colorName,
        image: image,
        size: size,
        createdAt: createdAt,
        price: price,
        productId: productId,
        brandname: brandname,
        title: title,
        brandimage: brandImageUrl,
      );

      return right(await cartLocalData.addToCart(productModel));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> bulkAddToCart({
    required String id,
    required String colorCode,
    required String colorName,
    required String image,
    required double size,
    required DateTime createdAt,
    required String productId,
    required double price,
    required String brandname,
    required String title,
    required String brandImageUrl,
    required int quantity,
  }) async {
    try {
      ProductVariationModel productModel = ProductVariationModel(
        id: id,
        colorCode: colorCode,
        colorName: colorName,
        image: image,
        size: size,
        createdAt: createdAt,
        price: price,
        productId: productId,
        brandname: brandname,
        title: title,
        brandimage: brandImageUrl,
      );

      return right(await cartLocalData.bulkAddToCart(
          productModel: productModel, quantity: quantity));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> bulkDeleteFromCart({
    required String id,
    required String colorCode,
    required String colorName,
    required String image,
    required double size,
    required DateTime createdAt,
    required String productId,
    required double price,
    required String brandname,
    required String title,
    required String brandImageUrl,
  }) async {
    try {
      ProductVariationModel product = ProductVariationModel(
          id: id,
          colorCode: colorCode,
          colorName: colorName,
          image: image,
          size: size,
          createdAt: createdAt,
          price: price,
          productId: productId,
          brandname: brandname,
          title: title,
          brandimage: brandImageUrl);
      return right(await cartLocalData.bulkDeleteFromCart(
        productModel: product,
      ));
    } on CacheException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> deleteFromCart({
    required String id,
    required String colorCode,
    required String colorName,
    required String image,
    required double size,
    required DateTime createdAt,
    required String productId,
    required String brandname,
    required String title,
    required String brandImageUrl,
    required double price,
  }) async {
    try {
      ProductVariationModel product = ProductVariationModel(
          id: id,
          colorCode: colorCode,
          colorName: colorName,
          image: image,
          size: size,
          createdAt: createdAt,
          price: price,
          productId: productId,
          brandname: brandname,
          title: title,
          brandimage: brandImageUrl);
      return right(await cartLocalData.deleteFromCart(product));
    } on CacheException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      final cart = await cartLocalData.getCart();
      return right(cart);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
