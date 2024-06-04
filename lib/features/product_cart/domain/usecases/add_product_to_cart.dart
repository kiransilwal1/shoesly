import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';

import '../../../../core/entities/product_variation.dart';
import '../entities/cart.dart';
import '../repositories/cart_repo.dart';

class ProductAddToCartUseCase implements UseCase<Cart, ProductVariation> {
  final ProductCartRepo cartRepo;

  ProductAddToCartUseCase({required this.cartRepo});
  @override
  Future<Either<Failure, Cart>> call(ProductVariation params) async {
    return await cartRepo.addToCart(
        id: params.id,
        colorCode: params.colorCode,
        colorName: params.colorName,
        createdAt: params.createdAt,
        image: params.image,
        price: params.price,
        productId: params.productId,
        size: params.size,
        brandname: params.brandname,
        title: params.title,
        brandImageUrl: params.brandimage);
  }
}
