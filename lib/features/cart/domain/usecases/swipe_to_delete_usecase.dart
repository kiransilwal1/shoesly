// import 'package:fpdart/fpdart.dart';
// import 'package:shoesly/core/error/failures.dart';
// import 'package:shoesly/core/usecase/usecase.dart';
// import 'package:shoesly/features/cart/domain/entities/cart.dart';
// import 'package:shoesly/features/cart/domain/repositories/cart_repo.dart';

// import '../entities/cart_items.dart';

// class SwipeToDeleteUseCase implements UseCase<Cart, CartItems> {
//   final CartRepo cartRepo;

//   SwipeToDeleteUseCase({required this.cartRepo});
//   @override
//   Future<Either<Failure, Cart>> call(CartItems params) async {
//     return await cartRepo.swipeToRemove(cartItems: params);
//   }
// }
