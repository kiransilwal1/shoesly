import 'package:fpdart/fpdart.dart';

import 'package:shoesly/features/product_discover/domain/entities/filter_entity.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/filter_params.dart';

abstract interface class ProductRepo {
  Future<Either<Failure, ProductDataEntity>> getProduct();
  Future<Either<Failure, FilterEntity>> getFilterParams(
      ProductDataEntity params);
  Future<Either<Failure, ProductDataEntity>> filterProducts(
      FilterParams filters);
}
