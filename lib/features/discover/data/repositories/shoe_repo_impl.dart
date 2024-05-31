import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/exceptions.dart';

import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/discover/data/datasources/shoe_remote_datasource.dart';
import 'package:shoesly/features/discover/domain/entities/discover.dart';

import 'package:shoesly/features/discover/domain/entities/shoes.dart';

import '../../domain/repositories/shoe_repo.dart';

class ShoeRepoImpl implements ShoeRepo {
  final ShoeRemoteDataSource shoeRemoteDataSource;

  ShoeRepoImpl({required this.shoeRemoteDataSource});

  @override
  Future<Either<Failure, Discover>> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  }) async {
    try {
      final shoes = await shoeRemoteDataSource.filterShoes(
        color: color,
        gender: gender,
        maxPrice: maxPrice,
        minPrice: minPrice,
        shoeBrand: shoeBrand,
        sortBy: sortBy,
      );
      return right(shoes);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
