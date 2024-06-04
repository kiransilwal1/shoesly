part of 'product_detail_bloc.dart';

sealed class ProductDetailState {
  const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final ProductDetailEntity productDetailEntity;

  ProductDetailSuccess({required this.productDetailEntity});
}

class ProudctDetailFailure extends ProductDetailState {
  final String errorMessage;

  ProudctDetailFailure({required this.errorMessage});
}
