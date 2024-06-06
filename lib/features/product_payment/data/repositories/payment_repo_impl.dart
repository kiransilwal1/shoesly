import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/core/entities/cart.dart';
import 'package:shoesly/features/product_payment/data/datasources/payment_remote_datasource.dart';

import 'package:shoesly/features/product_payment/domain/repositories/payment_repo.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/common/network/connection_checker.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentRemoteDatasource paymentRemoteDataSource;
  final ConnectionChecker connectionChecker;

  PaymentRepoImpl(
      {required this.connectionChecker, required this.paymentRemoteDataSource});
  @override
  Future<Either<Failure, String>> initiatePayment({required Cart cart}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      return right(await paymentRemoteDataSource.initiatePayment(cart));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> checkout({required Cart cart}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      return right(await paymentRemoteDataSource.checkout(cart));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
