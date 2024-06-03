part of 'product_detail_v2_bloc.dart';

sealed class ProductDetailV2Event {
  const ProductDetailV2Event();
}

final class ProductDetailLoadEvent extends ProductDetailV2Event {
  final String id;

  ProductDetailLoadEvent({required this.id});
}
