part of 'paywall_bloc.dart';

sealed class ProductPaymentEvent {
  const ProductPaymentEvent();
}

final class PaymentInitiated extends ProductPaymentEvent {
  final Cart cart;

  PaymentInitiated({required this.cart});
}

final class CheckOut extends ProductPaymentEvent {
  final Cart cart;

  CheckOut({required this.cart});
}
