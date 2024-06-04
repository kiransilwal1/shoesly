import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_params.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';
import 'package:shoesly/features/product_discover/domain/repositories/product_discover_repo.dart';

class FilterProductPageUseCase
    implements UseCase<ProductDataEntity, FilterParams> {
  final ProductRepo productRepo;

  FilterProductPageUseCase({required this.productRepo});
  @override
  Future<Either<Failure, ProductDataEntity>> call(FilterParams params) async {
    return await productRepo.filterProducts(params);
  }
}
