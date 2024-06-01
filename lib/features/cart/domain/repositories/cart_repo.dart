import 'package:fpdart/fpdart.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(ShoeVariations shoe);
  Future<Either<Failure, void>> removeFromCart(ShoeVariations shoe);
  Stream<Cart> getCart();
}
