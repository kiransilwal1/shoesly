part of 'product_detail_bloc.dart';

sealed class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailFailure extends ProductDetailState {
  final String errorMessage;

  ProductDetailFailure({required this.errorMessage});
}

class ProductDetailSuccess extends ProductDetailState {
  final ShoeDetailsEntity shoeDetailsEntity;

  ProductDetailSuccess({required this.shoeDetailsEntity});
}
