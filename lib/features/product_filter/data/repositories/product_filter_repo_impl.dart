import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/entities/brands.dart';
import 'package:shoesly/core/entities/product_discover_entity.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_filter/domain/usecases/filter_page_usecase.dart';

import '../../domain/repositories/product_filter_repo.dart';
import '../datasources/product_filter_datasource.dart';

class ProductFilterRepoImpl implements ProductFilterRepo {
  final ProductFilterRemoteDatasource productFilterRemoteDatasource;

  ProductFilterRepoImpl({required this.productFilterRemoteDatasource});
  @override
  Future<Either<Failure, List<Brand>>> getBrands() async {
    try {
      return right(await productFilterRemoteDatasource.getBrands());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> filterProducts(
      FilterParams params) async {
    try {
      return right(await productFilterRemoteDatasource.filterProducts(params));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
