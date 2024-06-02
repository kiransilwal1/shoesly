import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';
import 'package:shoesly/features/product-detail/domain/repositories/product_detail_repo.dart';

class ProductDetailUseCase implements UseCase<ShoeDetailsEntity, String> {
  final ProductDetailRepo productDetailRepo;

  ProductDetailUseCase({required this.productDetailRepo});
  @override
  Future<Either<Failure, ShoeDetailsEntity>> call(String params) async {
    return await productDetailRepo.getShoeDetailEntity(shoeId: params);
  }
}
