part of 'product_discover_bloc.dart';

sealed class ProductDiscoverEvent {}

final class ProductDiscoverInitiated extends ProductDiscoverEvent {}

class FilterProductsEvent extends ProductDiscoverEvent {
  final List<Product> filteredProducts;

  FilterProductsEvent({required this.filteredProducts});
}

final class ProductFilterInitiated extends ProductDiscoverEvent {}

final class FilterButtonPressed extends ProductDiscoverEvent {
  final String? shoeBrand;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? gender;
  final String? color;

  FilterButtonPressed(
      {this.shoeBrand,
      this.minPrice,
      this.maxPrice,
      this.sortBy,
      this.gender,
      this.color});
}
