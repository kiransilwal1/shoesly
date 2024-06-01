import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoesly/features/product-detail/domain/usecases/get_productdetail_usecase.dart';

part 'filter_count_event.dart';
part 'filter_count_state.dart';

class FilterCountBloc extends Bloc<FilterCountEvents, FilterCountState> {
  FilterCountBloc() : super(FilterCountInitial()) {
    on<AddFilterEvent>(_addFilter);
    on<SubstractCountEvent>(_removeFilter);
  }

  FutureOr<void> _addFilter(
      AddFilterEvent event, Emitter<FilterCountState> emit) {
    emit(FilterCountUpdatedState(event.count + 1));
  }

  FutureOr<void> _removeFilter(
      SubstractCountEvent event, Emitter<FilterCountState> emit) {
    emit(FilterCountUpdatedState(event.count - 1));
  }
}
