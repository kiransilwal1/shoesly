import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/discover/domain/repositories/shoe_repo.dart';

import '../entities/shoes.dart';

class GetShoes implements UseCase<List<Shoe>, NoParams> {
  final ShoeRepo shoeRepo;

  GetShoes({required this.shoeRepo});
  @override
  Future<Either<Failure, List<Shoe>>> call(NoParams params) async {
    return await shoeRepo.getAllShoes();
  }
}
