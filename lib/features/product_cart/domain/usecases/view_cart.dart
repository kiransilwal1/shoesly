import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/core/common/usecase/usecase.dart';

import '../../../../core/entities/cart.dart';
import '../repositories/cart_repo.dart';

class ViewCartUseCase implements UseCase<Cart, NoParams> {
  final ProductCartRepo productCartRepo;

  ViewCartUseCase({required this.productCartRepo});
  @override
  Future<Either<Failure, Cart>> call(NoParams params) async {
    return await productCartRepo.getCart();
  }
}
