import 'package:fpdart/src/either.dart';
import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product-detail/data/datasources/product_detail_data_source.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';
import 'package:shoesly/features/product-detail/domain/repositories/product_detail_repo.dart';

class ProductDetailRepoImpl implements ProductDetailRepo {
  final ProductDetailDataSource productDetailDataSource;

  ProductDetailRepoImpl({required this.productDetailDataSource});

  @override
  Future<Either<Failure, ShoeDetailsEntity>> getShoeDetailEntity(
      {required String shoeId}) async {
    try {
      final productDetail =
          await productDetailDataSource.getShoeDetail(id: shoeId);
      return right(productDetail);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
    throw UnimplementedError();
  }
}
