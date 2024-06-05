import 'package:fpdart/src/either.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_payment/domain/repositories/payment_repo.dart';

import '../../../product_cart/domain/entities/cart.dart';

class CheckoutUseCase implements UseCase<Cart, Cart> {
  final PaymentRepo paymentRepo;

  CheckoutUseCase({required this.paymentRepo});
  @override
  Future<Either<Failure, Cart>> call(Cart params) async {
    return await paymentRepo.checkout(cart: params);
  }
}
