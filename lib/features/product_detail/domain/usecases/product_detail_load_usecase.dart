import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/core/common/usecase/usecase.dart';
import 'package:shoesly/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shoesly/features/product_detail/domain/repositories/product_detail_rep.dart';

class ProductDetailLoadUseCase implements UseCase<ProductDetailEntity, String> {
  final ProductDetailRepo productDetailRepo;

  ProductDetailLoadUseCase({required this.productDetailRepo});
  @override
  Future<Either<Failure, ProductDetailEntity>> call(String params) async {
    return await productDetailRepo.loadProductDetails(params);
  }
}
