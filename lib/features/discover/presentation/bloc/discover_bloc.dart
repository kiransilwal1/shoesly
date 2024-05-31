import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/discover/domain/usecases/get_filtered_shoes.dart';

import '../../domain/entities/shoes.dart';
import '../../domain/usecases/get_all_shoe.dart';
part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetFilterShoes _getFilterShoes;
  DiscoverBloc({required GetFilterShoes getFilterShoes})
      : _getFilterShoes = getFilterShoes,
        super(DiscoverInitial()) {
    on<DiscoverEvent>((event, emit) => DiscoverLoading());
    on<FilterShoes>(_filterShoes);
  }

  FutureOr<void> _filterShoes(
      FilterShoes event, Emitter<DiscoverState> emit) async {
    emit(DiscoverLoading());
    final res = await _getFilterShoes(FilterParams(
      color: event.color,
      gender: event.gender,
      maxPrice: event.maxPrice,
      minPrice: event.minPrice,
      shoeBrand: event.shoeBrand,
      sortBy: event.sortBy,
    ));
    res.fold((l) => emit(ShoeFilterFailure(errorMessage: l.message)),
        (r) => emit(DiscoverSuccess(shoes: r.shoes, filterParams: r.params)));
  }
}
