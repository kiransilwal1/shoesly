part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent {
  const ProductDetailEvent();
}

final class ProductDetailLoadEvent extends ProductDetailEvent {
  final String id;

  ProductDetailLoadEvent({required this.id});
}
