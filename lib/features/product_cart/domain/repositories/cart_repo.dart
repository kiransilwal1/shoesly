import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/product_discover_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart.dart';

abstract class ProductCartRepo {
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
  });
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
  });
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
      required int quantity});
  Future<Either<Failure, List<Product>>> bulkAddToCart(
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
      required int quantity});
}
