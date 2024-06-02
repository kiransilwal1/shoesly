part of 'cart_bloc.dart';

sealed class CartEvent {}

final class AddToCartEvent extends CartEvent {
  final ShoeVariations shoe;
  final int quantity;

  AddToCartEvent({required this.shoe, required this.quantity});
}

final class RemoveFromCartEvent extends CartEvent {
  final ShoeVariations shoe;

  RemoveFromCartEvent({required this.shoe});
}

final class SwipeToDeleteEvent extends CartEvent {
  final ShoeVariations shoe;
  final int quantity;

  SwipeToDeleteEvent({required this.shoe, required this.quantity});
}

final class GetCartEvent extends CartEvent {}
