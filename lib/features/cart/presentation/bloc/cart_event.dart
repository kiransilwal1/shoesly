part of 'cart_bloc.dart';

sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final ShoeVariations shoe;

  AddToCartEvent(this.shoe);
}

class LoadCart extends CartEvent {}

class RemoveFromCartEvent extends CartEvent {
  final ShoeVariations shoe;

  RemoveFromCartEvent(this.shoe);
}

class CartUpdatedEvent extends CartEvent {
  final Cart cart;

  CartUpdatedEvent(this.cart);
}
