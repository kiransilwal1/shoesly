import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_discover/data/datasources/product_remote_datasource.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_entity.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';
import 'package:shoesly/features/product_discover/domain/repositories/product_discover_repo.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/entities/filter_params.dart';
import '../models/product_data_model.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource productRemoteDataSource;
  final ConnectionChecker connectionChecker;

  ProductRepoImpl(
      {required this.productRemoteDataSource, required this.connectionChecker});
  @override
  Future<Either<Failure, ProductDataEntity>> getProduct() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final result = await productRemoteDataSource.getProduct();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on SocketException catch (e) {
      return left(Failure('Please connect to the internet!'));
    }
  }

  @override
  Future<Either<Failure, FilterEntity>> getFilterParams(
      ProductDataEntity params) async {
    try {
      final result = await productRemoteDataSource
          .getFilterParams(params as ProductDataModel);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDataEntity>> filterProducts(
      FilterParams filters) async {
    try {
      final result = await productRemoteDataSource.filterProducts(filters);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
