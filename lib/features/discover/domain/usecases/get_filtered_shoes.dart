import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/discover/domain/repositories/shoe_repo.dart';

import '../entities/shoes.dart';

class GetFilterShoes implements UseCase<List<Shoe>, FilterParams> {
  final ShoeRepo shoeRepo;

  GetFilterShoes({required this.shoeRepo});
  @override
  Future<Either<Failure, List<Shoe>>> call(FilterParams params) async {
    return await shoeRepo.filterShoes(
        color: params.color,
        gender: params.gender,
        maxPrice: params.maxPrice,
        minPrice: params.minPrice,
        shoeBrand: params.shoeBrand,
        sortBy: params.sortBy);
  }
}

class FilterParams {
  final String? shoeBrand;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? gender;
  final String? color;

  FilterParams(
      {this.shoeBrand,
      this.minPrice,
      this.maxPrice,
      this.sortBy,
      this.gender,
      this.color});
}
