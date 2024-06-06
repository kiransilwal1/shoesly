import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/entities/product_variation.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/core/common/usecase/usecase.dart';
import 'package:shoesly/features/product_cart/domain/repositories/cart_repo.dart';

import '../../../../core/entities/cart.dart';

class DeleteFromCartUseCase implements UseCase<Cart, ProductVariation> {
  final ProductCartRepo productCartRepo;

  DeleteFromCartUseCase({required this.productCartRepo});
  @override
  Future<Either<Failure, Cart>> call(ProductVariation params) async {
    return await productCartRepo.deleteFromCart(
      id: params.id,
      colorCode: params.colorCode,
      colorName: params.colorName,
      image: params.image,
      size: params.size,
      createdAt: params.createdAt,
      productId: params.productId,
      price: params.price,
      brandname: params.brandname,
      title: params.title,
      brandImageUrl: params.brandimage,
    );
  }
}
