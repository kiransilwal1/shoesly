import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/product_filter/domain/usecases/filter_page_usecase.dart';

import '../../../../core/entities/brands.dart';
import '../../../../core/entities/product_discover_entity.dart';
import '../../../../core/error/failures.dart';

abstract class ProductFilterRepo {
  Future<Either<Failure, List<Brand>>> getBrands();
  Future<Either<Failure, List<Product>>> filterProducts(FilterParams params);
}
