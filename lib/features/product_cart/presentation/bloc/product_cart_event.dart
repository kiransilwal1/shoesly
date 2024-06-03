part of 'product_cart_bloc.dart';

sealed class ProductCartEvent {
  const ProductCartEvent();
}

final class AddToCart extends ProductCartEvent {
  final ProductVariations product;

  AddToCart({required this.product});
}

final class RemoveFromCart extends ProductCartEvent {}
