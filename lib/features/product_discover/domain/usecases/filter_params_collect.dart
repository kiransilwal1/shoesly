import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_entity.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';

import '../repositories/product_discover_repo.dart';

class FilterParamsCollectUseCase
    implements UseCase<FilterEntity, ProductDataEntity> {
  final ProductRepo productRepo;

  FilterParamsCollectUseCase({required this.productRepo});
  @override
  Future<Either<Failure, FilterEntity>> call(ProductDataEntity params) async {
    return await productRepo.getFilterParams(params);
  }
}
