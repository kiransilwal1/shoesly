import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/discover/domain/entities/filter_entity.dart';

import '../repositories/shoe_repo.dart';

class GetFilterParams implements UseCase<FilterEntity, NoParams> {
  final ShoeRepo shoeRepo;

  GetFilterParams({required this.shoeRepo});
  @override
  Future<Either<Failure, FilterEntity>> call(NoParams params) async {
    return await shoeRepo.filterParams();
  }
}
