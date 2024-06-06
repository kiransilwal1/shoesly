import 'package:fpdart/fpdart.dart';
import '../../../../core/common/error/failures.dart';
import '../../../../core/entities/cart.dart';

abstract interface class ProductCartRepo {
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
  });
  Future<Either<Failure, Cart>> deleteFromCart({
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
  });
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
  });
  Future<Either<Failure, Cart>> bulkAddToCart(
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
      required String brandImageUrl,
      required int quantity});

  Future<Either<Failure, Cart>> getCart();
}
