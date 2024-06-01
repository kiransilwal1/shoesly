part of 'discover_bloc.dart';

sealed class DiscoverState {}

final class DiscoverInitial extends DiscoverState {}

final class DiscoverFailure extends DiscoverState {
  final String errorMessage;

  DiscoverFailure({required this.errorMessage});
}

final class DiscoverSuccess extends DiscoverState {
  final List<ShoeEntity.Shoe> shoes;
  final FilterParams filterParams;

  DiscoverSuccess({required this.shoes, required this.filterParams});
}

final class DiscoverLoading extends DiscoverState {}

final class ShoeFilterSuccess extends DiscoverState {}

final class FilterLoading extends DiscoverState {}

final class FilterFailure extends DiscoverState {
  final String errorMessage;

  FilterFailure(this.errorMessage);
}

final class FilterParamSuccess extends DiscoverState {
  final List<Brand> brands;
  final double minPrice;
  final double maxPrice;
  final List<ColorEntity> colorCodes;

  FilterParamSuccess({
    required this.brands,
    required this.minPrice,
    required this.maxPrice,
    required this.colorCodes,
  });
}

final class ShoeFilterFailure extends DiscoverState {
  final String errorMessage;

  ShoeFilterFailure({required this.errorMessage});
}
