import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product_detail_v2/data/datasources/product_detail_remote.dart';
import 'package:shoesly/features/product_detail_v2/domain/entities/product_detail_entity.dart';
import 'package:shoesly/features/product_detail_v2/domain/repositories/product_detail_rep.dart';

class ProductDetailRepoImplV2 implements ProductDetailRepov2 {
  final ProductDetailRemote productDetailRemote;

  ProductDetailRepoImplV2({required this.productDetailRemote});
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
