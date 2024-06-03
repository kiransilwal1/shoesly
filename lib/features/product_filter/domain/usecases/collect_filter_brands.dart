import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/entities/brands.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_filter/domain/repositories/product_filter_repo.dart';

class BrandFilterCollectionUsecase implements UseCase<List<Brand>, NoParams> {
  final ProductFilterRepo productFilterRepo;

  BrandFilterCollectionUsecase({required this.productFilterRepo});
  @override
  Future<Either<Failure, List<Brand>>> call(NoParams params) async {
    return await productFilterRepo.getBrands();
  }
}
