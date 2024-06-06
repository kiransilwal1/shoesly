import 'package:fpdart/fpdart.dart';

import '../../../../core/common/error/failures.dart';
import '../../../../core/entities/cart.dart';

abstract interface class PaymentRepo {
  Future<Either<Failure, String>> initiatePayment({required Cart cart});

  Future<Either<Failure, Cart>> checkout({required Cart cart});
}
