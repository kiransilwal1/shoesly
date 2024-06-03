import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/entities/product_discover_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> getProduct();
}
