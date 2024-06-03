import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_filter/domain/repositories/product_filter_repo.dart';

import '../../../../core/entities/product_discover_entity.dart';

class FilterPageUsecase implements UseCase<List<Product>, FilterParams> {
  final ProductFilterRepo productFilterRepo;

  FilterPageUsecase({required this.productFilterRepo});

  @override
  Future<Either<Failure, List<Product>>> call(FilterParams params) async {
    return await productFilterRepo.filterProducts(params);
  }
}

class FilterParams {
  final String? shoeBrand;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? gender;
  final String? color;

  FilterParams(
      {this.shoeBrand,
      this.minPrice,
      this.maxPrice,
      this.sortBy,
      this.gender,
      this.color});
}
