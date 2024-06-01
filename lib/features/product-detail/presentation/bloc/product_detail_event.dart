part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent {}

final class ProductClickEvent extends ProductDetailEvent {
  final int shoeId;

  ProductClickEvent({required this.shoeId});
}
