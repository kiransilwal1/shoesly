import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';

import '../../../product_cart/domain/entities/cart.dart';
import '../repositories/payment_repo.dart';

class ProductPaymentInitiateUsecase implements UseCase<Cart, Cart> {
  final PaymentRepo paymentRepo;

  ProductPaymentInitiateUsecase({required this.paymentRepo});
  @override
  Future<Either<Failure, Cart>> call(Cart params) async {
    return await paymentRepo.checkout(cart: params);
  }
}
