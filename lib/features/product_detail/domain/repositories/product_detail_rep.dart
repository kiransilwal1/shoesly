import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/product_detail/domain/entities/product_detail_entity.dart';

import '../../../../core/error/failures.dart';

abstract interface class ProductDetailRepo {
  Future<Either<Failure, ProductDetailEntity>> loadProductDetails(String id);
}
