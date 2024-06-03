// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shoesly/core/usecase/usecase.dart';
// import 'package:shoesly/features/product_filter/domain/usecases/collect_filter_brands.dart';
// import 'package:shoesly/features/product_filter/domain/usecases/filter_page_usecase.dart';

// import '../../../../core/entities/brands.dart';
// part 'product_filter_event.dart';
// part 'product_filter_state.dart';

// class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
//   final BrandFilterCollectionUsecase _brandFilterCollectionUsecase;
//   final FilterPageUsecase _filterPageUsecase;

//   ProductFilterBloc({
//     required BrandFilterCollectionUsecase brandFilterCollectionUsecase,
//     required FilterPageUsecase filterPageUsecase,
//   })  : _brandFilterCollectionUsecase = brandFilterCollectionUsecase,
//         _filterPageUsecase = filterPageUsecase,
//         super(ProductFilterInitial()) {
//     on<ProductFilterEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//     on<ProductFilterInitiated>(_initiateFilterFeature);
//     // on<FilterButtonPressed>(_filterDiscoverPage);
//   }

//   FutureOr<void> _initiateFilterFeature(
//       ProductFilterInitiated event, Emitter<ProductFilterState> emit) async {
//     final res = await _brandFilterCollectionUsecase(NoParams());
//     res.fold((l) => emit(ProductFilterFailure(errorMessage: l.message)),
//         (r) => emit(ProductFilterCollectBrand(r)));
//   }

  // FutureOr<void> _filterDiscoverPage(
  //     FilterButtonPressed event, Emitter<ProductFilterState> emit) async {
  //   final res = await _filterPageUsecase(FilterParams(
  //       color: event.color,
  //       gender: event.gender,
  //       maxPrice: event.maxPrice,
  //       minPrice: event.minPrice,
  //       shoeBrand: event.shoeBrand,
  //       sortBy: event.sortBy));

  //   res.fold((l) => emit(ProductDiscoverFailure(errorMessage: l.message)), (r) => ProductDiscoverSuccess(products: r));
  // }
// }
