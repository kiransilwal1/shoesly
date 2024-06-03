import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/product_discover_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart.dart';

abstract class ProductCartRepo {
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
  });
  Future<Either<Failure, List<Product>>> deleteFromCart({
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
  });
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
      required int quantity});
  Future<Either<Failure, List<Product>>> bulkAddToCart(
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
      required int quantity});

  Future<Either<Failure, Cart>> getCart();
}
