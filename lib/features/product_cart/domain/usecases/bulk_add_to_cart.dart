import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_cart/domain/entities/bulk_add_params.dart';
import 'package:shoesly/features/product_cart/domain/repositories/cart_repo.dart';

import '../entities/cart.dart';

class BulkAddToCartUseCase implements UseCase<Cart, BulkAddParams> {
  final ProductCartRepo productCartRepo;

  BulkAddToCartUseCase({required this.productCartRepo});
  @override
  Future<Either<Failure, Cart>> call(BulkAddParams params) async {
    return await productCartRepo.bulkAddToCart(
        id: params.productVariation.id,
        colorCode: params.productVariation.colorCode,
        colorName: params.productVariation.colorName,
        image: params.productVariation.image,
        size: params.productVariation.size,
        createdAt: params.productVariation.createdAt,
        productId: params.productVariation.productId,
        price: params.productVariation.price,
        brandname: params.productVariation.brandname,
        title: params.productVariation.title,
        brandImageUrl: params.productVariation.brandimage,
        quantity: params.count);
  }
}
