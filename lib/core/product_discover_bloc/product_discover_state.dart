part of 'product_discover_bloc.dart';

sealed class ProductDiscoverState {}

final class ProductDiscoverInitial extends ProductDiscoverState {}

final class ProductDiscoverSuccess extends ProductDiscoverState {
  final List<Product> products;
  final FilterParams filterParams;

  ProductDiscoverSuccess({required this.products, required this.filterParams});
}

final class ProductDiscoverFailure extends ProductDiscoverState {
  final String errorMessage;

  ProductDiscoverFailure({required this.errorMessage});
}

final class ProductFilterInitial extends ProductDiscoverState {}

final class ProductFilterCollectBrand extends ProductDiscoverState {
  final List<Brand> brandNames;

  ProductFilterCollectBrand(this.brandNames);
}

final class ProductFilterFailure extends ProductDiscoverState {
  final String errorMessage;

  ProductFilterFailure({required this.errorMessage});
}

final class ProductFilterSuccess extends ProductDiscoverState {}
