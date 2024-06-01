part of 'filter_count_bloc.dart';

sealed class FilterCountState {}

final class FilterCountInitial extends FilterCountState {}

final class FilterCountUpdatedState extends FilterCountState {
  final int filters;
  FilterCountUpdatedState(this.filters);
}
