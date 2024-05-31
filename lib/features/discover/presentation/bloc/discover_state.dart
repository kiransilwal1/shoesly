part of 'discover_bloc.dart';

sealed class DiscoverState {}

final class DiscoverInitial extends DiscoverState {}

final class DiscoverFailure extends DiscoverState {
  final String errorMessage;

  DiscoverFailure({required this.errorMessage});
}

final class DiscoverSuccess extends DiscoverState {
  final List<Shoe> shoes;
  final FilterParams filterParams;

  DiscoverSuccess({required this.shoes, required this.filterParams});
}

final class DiscoverLoading extends DiscoverState {}

final class ShoeFilterSuccess extends DiscoverState {}

final class ShoeFilterIntialState extends DiscoverState {}

final class ShoeFilterFailure extends DiscoverState {
  final String errorMessage;

  ShoeFilterFailure({required this.errorMessage});
}
