part of 'product_discover_bloc.dart';

sealed class ProductDiscoverState {}

final class ProductDiscoverInitial extends ProductDiscoverState {}

final class ProductDiscoverSuccess extends ProductDiscoverState {
  final ProductDataEntity productData;
  final ProductDataEntity globalProductData;

  ProductDiscoverSuccess(
      {required this.productData, required this.globalProductData});
}

final class ProductDiscoverFailure extends ProductDiscoverState {
  final String errorMessage;

  ProductDiscoverFailure({required this.errorMessage});
}

final class ProductFilterFailure extends ProductDiscoverState {
  final String errorMessage;

  ProductFilterFailure({required this.errorMessage});
}

final class FilterParamSuccess extends ProductDiscoverState {
  final FilterEntity filterEntity;
  final ProductDataEntity globalData;
  final ProductDataEntity localData;

  FilterParamSuccess(
      {required this.filterEntity,
      required this.globalData,
      required this.localData});
}

final class NoElement extends ProductDiscoverState {}
