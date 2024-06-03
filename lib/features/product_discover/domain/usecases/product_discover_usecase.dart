import 'package:fpdart/src/either.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_discover/domain/repositories/product_discover_repo.dart';

import '../../../../core/entities/product_discover_entity.dart';

class ProductDiscoverUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepo productRepo;

  ProductDiscoverUsecase({required this.productRepo});
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await productRepo.getProduct();
  }
}
