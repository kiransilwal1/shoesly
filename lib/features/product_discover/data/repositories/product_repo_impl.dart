import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_discover/data/datasources/product_remote_datasource.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_entity.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';
import 'package:shoesly/features/product_discover/domain/repositories/product_discover_repo.dart';

import '../../domain/entities/filter_params.dart';
import '../models/product_data_model.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepoImpl({required this.productRemoteDataSource});
  @override
  Future<Either<Failure, ProductDataEntity>> getProduct() async {
    try {
      final result = await productRemoteDataSource.getProduct();
      // final products = result
      //     .map((e) => Product(
      //         id: e.id,
      //         title: e.title,
      //         averageRating: e.averageRating,
      //         price: e.price,
      //         reviewCount: e.reviewCount,
      //         brandImageUrl: e.brandImageUrl,
      //         productImageUrl: e.productImageUrl))
      //     .toList();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
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
