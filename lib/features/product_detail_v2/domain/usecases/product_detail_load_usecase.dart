import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_detail_v2/domain/entities/product_detail_entity.dart';
import 'package:shoesly/features/product_detail_v2/domain/repositories/product_detail_rep.dart';

class ProductDetailLoadUseCase implements UseCase<ProductDetailEntity, String> {
  final ProductDetailRepov2 productDetailRepo;

  ProductDetailLoadUseCase({required this.productDetailRepo});
  @override
  Future<Either<Failure, ProductDetailEntity>> call(String params) async {
    return await productDetailRepo.loadProductDetails(params);
  }
}
