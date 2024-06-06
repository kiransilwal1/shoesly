import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/core/common/usecase/usecase.dart';

import '../../../../core/entities/cart.dart';
import '../repositories/payment_repo.dart';

class ProductPaymentInitiateUsecase implements UseCase<String, Cart> {
  final PaymentRepo paymentRepo;

  ProductPaymentInitiateUsecase({required this.paymentRepo});
  @override
  Future<Either<Failure, String>> call(Cart params) async {
    return await paymentRepo.initiatePayment(cart: params);
  }
}
