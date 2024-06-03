import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/core/entities/product_discover_entity.dart';
import 'package:shoesly/features/product_discover/domain/usecases/product_discover_usecase.dart';

import '../../features/product_filter/domain/usecases/collect_filter_brands.dart';
import '../../features/product_filter/domain/usecases/filter_page_usecase.dart';
import '../entities/brands.dart';

part 'product_discover_event.dart';
part 'product_discover_state.dart';

class ProductDiscoverBloc
    extends Bloc<ProductDiscoverEvent, ProductDiscoverState> {
  final BrandFilterCollectionUsecase _brandFilterCollectionUsecase;
  final FilterPageUsecase _filterPageUsecase;
  final ProductDiscoverUsecase _productDiscoverUsecase;
  ProductDiscoverBloc({
    required ProductDiscoverUsecase productDiscoverUsecase,
    required BrandFilterCollectionUsecase brandFilterCollectionUsecase,
    required FilterPageUsecase filterPageUsecase,
  })  : _productDiscoverUsecase = productDiscoverUsecase,
        _brandFilterCollectionUsecase = brandFilterCollectionUsecase,
        _filterPageUsecase = filterPageUsecase,
        super(ProductDiscoverInitial()) {
    on<ProductDiscoverEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ProductDiscoverInitiated>(_productDiscover);
    // on<FilterProductsEvent>(_filterProducts);
    on<FilterButtonPressed>(_filterDiscoverPage);
  }
  // FutureOr<void> _filterProducts(
  //     FilterProductsEvent event, Emitter<ProductDiscoverState> emit) async {
  //   emit(ProductDiscoverSuccess(products: event.filteredProducts));
  // }

  FutureOr<void> _productDiscover(
      ProductDiscoverEvent event, Emitter<ProductDiscoverState> emit) async {
    final res = await _productDiscoverUsecase(NoParams());
    res.fold(
        (l) => emit(ProductDiscoverFailure(errorMessage: l.message)),
        (r) => emit(ProductDiscoverSuccess(
            products: r, filterParams: FilterParams(shoeBrand: 'All'))));
  }

  FutureOr<void> _initiateFilterFeature(
      ProductFilterInitiated event, Emitter<ProductDiscoverState> emit) async {
    final res = await _brandFilterCollectionUsecase(NoParams());
    res.fold((l) => emit(ProductFilterFailure(errorMessage: l.message)),
        (r) => emit(ProductFilterCollectBrand(r)));
  }

  FutureOr<void> _filterDiscoverPage(
      FilterButtonPressed event, Emitter<ProductDiscoverState> emit) async {
    final res = await _filterPageUsecase(FilterParams(
        color: event.color,
        gender: event.gender,
        maxPrice: event.maxPrice,
        minPrice: event.minPrice,
        shoeBrand: event.shoeBrand,
        sortBy: event.sortBy));
    debugPrint('emitting state');

    res.fold(
        (l) => emit(ProductDiscoverFailure(errorMessage: l.message)),
        (r) => emit(ProductDiscoverSuccess(
            products: r,
            filterParams: FilterParams(shoeBrand: event.shoeBrand))));
  }
}
