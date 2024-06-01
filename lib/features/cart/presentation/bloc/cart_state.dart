part of 'cart_bloc.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final Stream<Cart> cartItems;

  CartLoaded(this.cartItems);
}

final class CartLoading extends CartState {}

final class CartFailure extends CartState {
  final String errorMessage;

  CartFailure({required this.errorMessage});
}
