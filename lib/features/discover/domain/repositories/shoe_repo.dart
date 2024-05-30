import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/shoes.dart';

abstract interface class ShoeRepo {
  Future<Either<Failure, List<Shoe>>> getAllShoes();
}
