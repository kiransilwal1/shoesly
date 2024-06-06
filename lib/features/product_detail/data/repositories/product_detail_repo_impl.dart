import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/features/product_detail/data/datasources/product_detail_remote.dart';
import 'package:shoesly/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shoesly/features/product_detail/domain/repositories/product_detail_rep.dart';

class ProductDetailRepoImpl implements ProductDetailRepo {
  final ProductDetailRemote productDetailRemote;

  ProductDetailRepoImpl({required this.productDetailRemote});
  @override
  Future<Either<Failure, ProductDetailEntity>> loadProductDetails(
      String id) async {
    try {
      return right(await productDetailRemote.loadProductDetail(id: id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
