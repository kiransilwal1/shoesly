import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

import '../../../../core/error/failures.dart';

abstract class ProductDetailRepo {
  Future<Either<Failure, ShoeDetailsEntity>> getShoeDetailEntity({
    required String shoeId,
  });
}
