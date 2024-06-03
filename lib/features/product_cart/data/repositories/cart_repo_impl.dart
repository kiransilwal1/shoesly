import 'package:fpdart/src/either.dart';

import 'package:shoesly/core/entities/product_discover_entity.dart';

import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_cart/data/datasources/cart_local_data.dart';
import 'package:shoesly/features/product_cart/domain/entities/cart.dart';

import '../../domain/repositories/cart_repo.dart';
import '../models/product_variation_model.dart';

class ProductCartRepoImpl implements ProductCartRepo {
  final ProductCartLocalData cartLocalData;

  ProductCartRepoImpl({required this.cartLocalData});

  @override
  Future<Either<Failure, Cart>> addToCart({
    required id,
    required title,
    required averageRating,
    required price,
    required reviewCount,
    required brandImageUrl,
    required productImageUrl,
    required variationImageUrl,
    required availableSizes,
    required availableColors,
    required variationId,
  }) async {
    try {
      ProductVariationModel productModel = ProductVariationModel(
          id: id,
          title: title,
          averageRating: averageRating,
          price: price,
          reviewCount: reviewCount,
          brandImageUrl: brandImageUrl,
          productImageUrl: productImageUrl,
          availableColors: availableColors,
          availableSizes: availableSizes,
          variationImageUrl: variationImageUrl,
          variationId: variationId);
      return right(await cartLocalData.addToCart(productModel));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> bulkAddToCart({
    required id,
    required title,
    required averageRating,
    required price,
    required reviewCount,
    required brandImageUrl,
    required productImageUrl,
    required variationImageUrl,
    required availableSizes,
    required availableColors,
    required variationId,
    required int quantity,
  }) {
    // TODO: implement bulkAddToCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> bulkDeleteFromCart(
      {required id,
      required title,
      required averageRating,
      required price,
      required reviewCount,
      required brandImageUrl,
      required productImageUrl,
      required variationImageUrl,
      required availableSizes,
      required availableColors,
      required variationId,
      required int quantity}) {
    // TODO: implement bulkDeleteFromCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> deleteFromCart({
    required id,
    required title,
    required averageRating,
    required price,
    required reviewCount,
    required brandImageUrl,
    required productImageUrl,
    required variationImageUrl,
    required availableSizes,
    required availableColors,
    required variationId,
  }) {
    // TODO: implement deleteFromCart
    throw UnimplementedError();
  }
}
