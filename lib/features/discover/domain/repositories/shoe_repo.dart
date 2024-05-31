import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/shoes.dart';

abstract interface class ShoeRepo {
  Future<Either<Failure, List<Shoe>>> getAllShoes();
  Future<Either<Failure, List<Shoe>>> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  });
}
