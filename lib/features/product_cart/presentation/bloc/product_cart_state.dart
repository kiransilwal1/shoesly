part of 'product_cart_bloc.dart';

abstract class ProductCartState {
  const ProductCartState();
}

final class ProductCartInitial extends ProductCartState {}

final class ProductCartFailure extends ProductCartState {
  final String errorMessage;

  ProductCartFailure({required this.errorMessage});
}

final class ProductCartSuccess extends ProductCartState {
  final Cart cart;

  ProductCartSuccess({required this.cart});
}
