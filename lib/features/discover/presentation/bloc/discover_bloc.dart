import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/usecase/usecase.dart';

import '../../domain/entities/shoes.dart';
import '../../domain/usecases/get_all_shoe.dart';
part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetShoes _getShoe;
  DiscoverBloc({required GetShoes getShoe})
      : _getShoe = getShoe,
        super(DiscoverInitial()) {
    on<DiscoverEvent>((event, emit) => DiscoverLoading());
    on<FetchAllShoes>(_fetchAllshoes);
  }

  FutureOr<void> _fetchAllshoes(
      FetchAllShoes event, Emitter<DiscoverState> emit) async {
    final res = await _getShoe(NoParams());
    print(res);
    res.fold((l) => emit(DiscoverFailure(errorMessage: l.message)),
        (r) => emit(DiscoverSuccess(shoes: r)));
  }
}
