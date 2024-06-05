import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../product_cart/domain/entities/cart.dart';

abstract interface class PaymentRepo {
  Future<Either<Failure, String>> initiatePayment({required Cart cart});

  Future<Either<Failure, Cart>> checkout({required Cart cart});
}
