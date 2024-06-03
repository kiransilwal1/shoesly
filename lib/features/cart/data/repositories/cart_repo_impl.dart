// import 'package:fpdart/fpdart.dart';
// import 'package:shoesly/core/error/cache_exceptions.dart';
// import 'package:shoesly/core/error/failures.dart';
// import 'package:shoesly/features/cart/data/datasources/cart_local_data_source.dart';
// import 'package:shoesly/features/cart/data/models/cart_item_model.dart';
// import 'package:shoesly/features/cart/data/models/cart_model.dart';
// import 'package:shoesly/features/cart/domain/entities/cart.dart';
// import 'package:shoesly/features/cart/domain/entities/cart_items.dart';
// import 'package:shoesly/features/cart/domain/repositories/cart_repo.dart';

// class CartRepoImpl implements CartRepo {
//   final CartLocalDataSource cartLocalDataSource;

//   CartRepoImpl({required this.cartLocalDataSource});
//   @override
//   Future<Either<Failure, void>> addItemsToCart(
//       {required CartItems cartItems}) async {
//     try {
//       CartItemModel cartItemModel = CartItemModel(
//           id: cartItems.id,
//           variations: cartItems.variations,
//           quantity: cartItems.quantity,
//           totalItemPrice: cartItems.totalItemPrice);

//       return right(await cartLocalDataSource.addItem(cartItemModel));
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, Cart>> getCartItems() async {
//     try {
//       Cart cart = await cartLocalDataSource.getCart();

//       return right(CartModel(
//           cartItems: cart.cartItems, totalCartPrice: cart.totalCartPrice));
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> removeItemsFromCart(
//       {required CartItems cartItems}) async {
//     // TODO: implement removeItemsFromCart
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, Cart>> swipeToRemove(
//       {required CartItems cartItems}) async {
//     try {
//       CartItemModel cartItemModel = CartItemModel(
//           id: cartItems.id,
//           variations: cartItems.variations,
//           quantity: cartItems.quantity,
//           totalItemPrice: cartItems.totalItemPrice);

//       return right(await cartLocalDataSource.swipeToRemove(cartItemModel));
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }
// }
