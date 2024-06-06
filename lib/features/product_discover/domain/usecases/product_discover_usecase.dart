import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/common/error/failures.dart';
import 'package:shoesly/core/common/usecase/usecase.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';
import 'package:shoesly/features/product_discover/domain/repositories/product_discover_repo.dart';

class ProductDiscoverUsecase implements UseCase<ProductDataEntity, NoParams> {
  final ProductRepo productRepo;

  ProductDiscoverUsecase({required this.productRepo});
  @override
  Future<Either<Failure, ProductDataEntity>> call(NoParams params) async {
    return await productRepo.getProduct();
  }
}
