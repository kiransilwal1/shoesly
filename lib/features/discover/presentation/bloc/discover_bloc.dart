import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/discover/domain/entities/color_entites.dart';
import 'package:shoesly/features/discover/domain/usecases/get_filter_data.dart';

import 'package:shoesly/features/discover/domain/usecases/get_filtered_shoes.dart';

import '../../domain/entities/brands.dart';
import '../../domain/entities/shoes.dart' as ShoeEntity;

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetFilterShoes _getFilterShoes;
  final GetFilterParams _getFilterParams;
  DiscoverBloc(
      {required GetFilterShoes getFilterShoes,
      required GetFilterParams getFilterParams})
      : _getFilterShoes = getFilterShoes,
        _getFilterParams = getFilterParams,
        super(DiscoverInitial()) {
    on<DiscoverEvent>((event, emit) => DiscoverLoading());
    on<FilterShoes>(_filterShoes);
    on<FilterPressed>(_filterPressed);
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

  FutureOr<void> _filterPressed(
      FilterPressed event, Emitter<DiscoverState> emit) async {
    emit(FilterLoading());
    final res = await _getFilterParams(NoParams());
    res.fold(
      (l) => emit(FilterFailure(l.message)),
      (r) => emit(
        FilterParamSuccess(
          brands: r.brands,
          minPrice: r.minPrice,
          maxPrice: r.maxPrice,
          colorCodes: r.colorCodes,
        ),
      ),
    );
  }
}
