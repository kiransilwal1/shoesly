// import 'package:fpdart/fpdart.dart';
// import 'package:shoesly/core/error/failures.dart';
// import 'package:shoesly/features/cart/domain/entities/cart_items.dart';

// import '../../../../core/usecase/usecase.dart';
// import '../repositories/cart_repo.dart';

// class AddToCartUsecase implements UseCase<void, CartItems> {
//   final CartRepo cartRepo;

//   AddToCartUsecase({required this.cartRepo});
//   @override
//   Future<Either<Failure, void>> call(CartItems params) async {
//     return await cartRepo.addItemsToCart(cartItems: params);
//   }
// }
// // 