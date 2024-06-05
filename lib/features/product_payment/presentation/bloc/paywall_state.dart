part of 'paywall_bloc.dart';

sealed class ProductPaymentState {
  const ProductPaymentState();
}

class ProductPaymentInitial extends ProductPaymentState {}

final class ProductPaymentSuccess extends ProductPaymentState {
  final String trackingId;

  ProductPaymentSuccess({required this.trackingId});
}

final class CheckoutSuccess extends ProductPaymentState {
  final Cart cart;

  CheckoutSuccess({required this.cart});
}

final class ProductPaymentFailure extends ProductPaymentState {
  final String errorMessage;

  ProductPaymentFailure({required this.errorMessage});
}
