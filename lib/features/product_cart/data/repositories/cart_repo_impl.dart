import 'package:fpdart/src/either.dart';

import 'package:shoesly/core/entities/product_discover_entity.dart';

import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_cart/data/datasources/cart_local_data.dart';
import 'package:shoesly/features/product_cart/domain/entities/cart.dart';

import '../../../product_detail_v2/data/models/product_variation_model.dart';
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
      );

      return right(await cartLocalData.addToCart(productModel));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> bulkAddToCart({
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
    required int quantity,
  }) {
    // TODO: implement bulkAddToCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> bulkDeleteFromCart(
      {required String id,
      required String colorCode,
      required String colorName,
      required String image,
      required double size,
      required DateTime createdAt,
      required String productId,
      required double price,
      required String brandname,
      required String title,
      required int quantity}) {
    // TODO: implement bulkDeleteFromCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> deleteFromCart({
    required String id,
    required String colorCode,
    required String colorName,
    required String image,
    required double size,
    required DateTime createdAt,
    required String productId,
    required String brandname,
    required String title,
    required double price,
  }) {
    // TODO: implement deleteFromCart
    throw UnimplementedError();
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
