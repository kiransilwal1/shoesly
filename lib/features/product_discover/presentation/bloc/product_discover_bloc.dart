import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/core/entities/product_discover_entity.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_entity.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_params.dart';
import 'package:shoesly/features/product_discover/domain/entities/product_data_entity.dart';
import 'package:shoesly/features/product_discover/domain/usecases/filter_product_page_usecase.dart';
import 'package:shoesly/features/product_discover/domain/usecases/product_discover_usecase.dart';
import '../../data/models/product_data_model.dart';
import '../../domain/usecases/filter_params_collect.dart';

part 'product_discover_event.dart';
part 'product_discover_state.dart';

class ProductDiscoverBloc
    extends Bloc<ProductDiscoverEvent, ProductDiscoverState> {
  final ProductDiscoverUsecase _productDiscoverUsecase;
  final FilterParamsCollectUseCase _filterParamsCollectUseCase;
  final FilterProductPageUseCase _filterProductPageUseCase;
  ProductDiscoverBloc({
    required FilterProductPageUseCase filterProductPageUseCase,
    required ProductDiscoverUsecase productDiscoverUsecase,
    required FilterParamsCollectUseCase filterParamsCollectUseCase,
  })  : _productDiscoverUsecase = productDiscoverUsecase,
        _filterParamsCollectUseCase = filterParamsCollectUseCase,
        _filterProductPageUseCase = filterProductPageUseCase,
        super(ProductDiscoverInitial()) {
    on<ProductDiscoverEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ProductDiscoverInitiated>(_productDiscover);
    on<PrepareFilterParams>(_prepareFilterParams);
    on<FilterButtonPressed>(_filterButtonPressed);
  }

  FutureOr<void> _productDiscover(
      ProductDiscoverEvent event, Emitter<ProductDiscoverState> emit) async {
    final res = await _productDiscoverUsecase(NoParams());
    res.fold(
        (l) => emit(ProductDiscoverFailure(errorMessage: l.message)),
        (r) =>
            emit(ProductDiscoverSuccess(productData: r, globalProductData: r)));
  }

  FutureOr<void> _prepareFilterParams(
      PrepareFilterParams event, Emitter<ProductDiscoverState> emit) async {
    final res = await _filterParamsCollectUseCase(event.globalProductData);
    res.fold(
        (l) => emit(ProductDiscoverFailure(errorMessage: l.message)),
        (r) => emit(FilterParamSuccess(
            filterEntity: r,
            globalData: event.globalProductData,
            localData: event.productData)));
  }

  FutureOr<void> _filterButtonPressed(
      FilterButtonPressed event, Emitter<ProductDiscoverState> emit) async {
    final res = await _filterProductPageUseCase(FilterParams(
        stateData: event.stateData as ProductDataModel,
        globalData: event.globalData as ProductDataModel,
        shoeBrand: event.shoeBrand,
        color: event.color,
        maxPrice: event.maxPrice,
        minPrice: event.minPrice,
        gender: null, //TODO: need to design database to support gender too.
        sortBy: event.sortBy));
    res.fold(
        (l) => emit(ProductDiscoverFailure(errorMessage: l.message)),
        (r) => emit(ProductDiscoverSuccess(
            productData: r, globalProductData: event.globalData)));
  }
}
