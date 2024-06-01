part of 'product_detail_bloc.dart';

sealed class ProductDetailState {}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailFailure extends ProductDetailState {
  final String errorMessage;

  ProductDetailFailure({required this.errorMessage});
}

final class ProductDetailSuccess extends ProductDetailState {
  final ShoeDetailsEntity shoeDetailsEntity;

  ProductDetailSuccess({required this.shoeDetailsEntity});
}
