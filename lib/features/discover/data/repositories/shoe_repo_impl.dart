import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/exceptions.dart';

import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/discover/data/datasources/shoe_remote_datasource.dart';

import 'package:shoesly/features/discover/domain/entities/shoes.dart';

import '../../domain/repositories/shoe_repo.dart';

class ShoeRepoImpl implements ShoeRepo {
  final ShoeRemoteDataSource shoeRemoteDataSource;

  ShoeRepoImpl({required this.shoeRemoteDataSource});
  @override
  Future<Either<Failure, List<Shoe>>> getAllShoes() async {
    try {
      final shoes = await shoeRemoteDataSource.getAllShoes();
      return right(shoes);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
