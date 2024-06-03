import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/core/entities/product_variations.dart';

import '../entities/cart.dart';
import '../repositories/cart_repo.dart';

class ProductAddToCartUseCase implements UseCase<Cart, ProductVariations> {
  final ProductCartRepo cartRepo;

  ProductAddToCartUseCase({required this.cartRepo});
  @override
  Future<Either<Failure, Cart>> call(ProductVariations params) async {
    return await cartRepo.addToCart(
        id: params.id,
        title: params.title,
        averageRating: params.averageRating,
        price: params.price,
        reviewCount: params.reviewCount,
        brandImageUrl: params.brandImageUrl,
        productImageUrl: params.productImageUrl,
        variationImageUrl: params.variationImageUrl,
        availableColors: params.availableColors,
        availableSizes: params.availableSizes,
        variationId: params.variationId);
  }
}
