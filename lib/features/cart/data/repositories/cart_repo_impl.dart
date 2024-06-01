import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/cart/domain/entities/cart.dart';
import 'package:shoesly/features/cart/domain/repositories/cart_repo.dart';
import 'package:shoesly/features/discover/domain/entities/shoes.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

import '../../../../core/error/failures.dart';
import '../datasources/local_datasource.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addToCart(ShoeVariations shoe) async {
    try {
      return right(localDataSource.addToCart(shoe));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(ShoeVariations shoe) async {
    try {
      return right(localDataSource.removeFromCart(shoe));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Stream<CartModel> getCart() {
    return localDataSource.getCart();
  }
}
