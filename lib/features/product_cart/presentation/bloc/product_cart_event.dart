part of 'product_cart_bloc.dart';

sealed class ProductCartEvent {
  const ProductCartEvent();
}

final class AddToCart extends ProductCartEvent {
  final ProductVariation product;

  AddToCart({required this.product});
}

final class RemoveFromCart extends ProductCartEvent {
  final ProductVariation product;

  RemoveFromCart({required this.product});
}

final class ViewCartEvent extends ProductCartEvent {}

final class BulkAddEvent extends ProductCartEvent {
  final ProductVariation product;
  final int quantity;

  BulkAddEvent({required this.product, required this.quantity});
}

final class DeleteEvent extends ProductCartEvent {
  final ProductVariation product;

  DeleteEvent({required this.product});
}
