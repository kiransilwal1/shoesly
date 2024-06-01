import 'package:fpdart/fpdart.dart';
import 'package:shoesly/core/error/failures.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repo.dart';

class AddToCart implements UseCase<void, ShoeVariations> {
  final CartRepository cartRepository;

  AddToCart({required this.cartRepository});
  @override
  Future<Either<Failure, void>> call(ShoeVariations params) async {
    return cartRepository.addToCart(params);
  }
}
