part of 'product_discover_bloc.dart';

sealed class ProductDiscoverEvent {}

final class ProductDiscoverInitiated extends ProductDiscoverEvent {}

class FilterProductsEvent extends ProductDiscoverEvent {
  final List<Product> filteredProducts;

  FilterProductsEvent({required this.filteredProducts});
}

final class FilterButtonPressed extends ProductDiscoverEvent {
  final String? shoeBrand;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? gender;
  final String? color;
  final ProductDataEntity stateData;
  final ProductDataEntity globalData;

  FilterButtonPressed(
      {this.shoeBrand,
      this.minPrice,
      this.maxPrice,
      this.sortBy,
      this.gender,
      this.color,
      required this.stateData,
      required this.globalData});
}

final class PrepareFilterParams extends ProductDiscoverEvent {
  final ProductDataEntity productData;
  final ProductDataEntity globalProductData;

  PrepareFilterParams(
      {required this.productData, required this.globalProductData});
}
