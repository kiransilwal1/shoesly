part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent {}

final class ProductClickEvent extends ProductDetailEvent {
  final String shoeId;

  ProductClickEvent({required this.shoeId});
}

final class ProductVariationSwipeEvent extends ProductDetailEvent {
  final ShoeDetailsEntity shoeVariations;

  ProductVariationSwipeEvent(this.shoeVariations);
}
