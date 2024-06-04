import 'package:fpdart/src/either.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';

import '../../../../core/entities/product_variation.dart';
import '../entities/cart.dart';

class BulkAddToCartUseCase implements UseCase<Cart, ProductVariation> {
  @override
  Future<Either<Failure, Cart>> call(ProductVariation params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
