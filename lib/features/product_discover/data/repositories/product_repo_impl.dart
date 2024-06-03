import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_discover/data/datasources/product_remote_datasource.dart';
import 'package:shoesly/core/entities/product_discover_entity.dart';
import 'package:shoesly/features/product_discover/domain/repositories/product_discover_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepoImpl({required this.productRemoteDataSource});
  @override
  Future<Either<Failure, List<Product>>> getProduct() async {
    try {
      final result = await productRemoteDataSource.getProduct();
      final products = result
          .map((e) => Product(
              id: e.id,
              title: e.title,
              averageRating: e.averageRating,
              price: e.price,
              reviewCount: e.reviewCount,
              brandImageUrl: e.brandImageUrl,
              productImageUrl: e.productImageUrl))
          .toList();
      return right(products);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
