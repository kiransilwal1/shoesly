import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/product_detail_v2/domain/entities/product_detail_entity.dart';

import '../../../../core/error/failures.dart';

abstract interface class ProductDetailRepov2 {
  Future<Either<Failure, ProductDetailEntity>> loadProductDetails(String id);
}
