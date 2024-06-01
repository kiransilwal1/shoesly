import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/discover/domain/entities/discover.dart';
import 'package:shoesly/features/discover/domain/entities/filter_entity.dart';

import '../../../../core/error/failures.dart';

abstract interface class ShoeRepo {
  Future<Either<Failure, Discover>> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  });

  Future<Either<Failure, FilterEntity>> filterParams();
}
