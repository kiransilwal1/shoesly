import 'package:fpdart/src/either.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/core/common/usecase/usecase.dart';
import 'package:shoesly/features/product_payment/domain/repositories/payment_repo.dart';

import '../../../../core/entities/cart.dart';

class CheckoutUseCase implements UseCase<Cart, Cart> {
  final PaymentRepo paymentRepo;

  CheckoutUseCase({required this.paymentRepo});
  @override
  Future<Either<Failure, Cart>> call(Cart params) async {
    return await paymentRepo.checkout(cart: params);
  }
}
