part of 'discover_bloc.dart';

sealed class DiscoverEvent {}

final class FilterShoes extends DiscoverEvent {
  final String? shoeBrand;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? gender;
  final String? color;

  FilterShoes(
      {this.shoeBrand,
      this.minPrice,
      this.maxPrice,
      this.sortBy,
      this.gender,
      this.color});
}

final class FilterPressed extends DiscoverEvent {}

final class FilterApply extends DiscoverEvent {}
