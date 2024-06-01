import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';
import 'package:shoesly/features/product-detail/domain/usecases/get_productdetail_usecase.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailUseCase _productDetailUseCase;

  ProductDetailBloc({required ProductDetailUseCase productDetailUseCase})
      : _productDetailUseCase = productDetailUseCase,
        super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) => emit(ProductDetailInitial()));
    on<ProductClickEvent>(_getProductDetail);
    on<ProductVariationSwipeEvent>(_swipeProduct);
  }

  FutureOr<void> _getProductDetail(
      ProductClickEvent event, Emitter<ProductDetailState> emit) async {
    final res = await _productDetailUseCase(event.shoeId);
    res.fold((l) => emit(ProductDetailFailure(errorMessage: l.message)),
        (r) => emit(ProductDetailSuccess(shoeDetailsEntity: r)));
  }

  FutureOr<void> _swipeProduct(
      ProductVariationSwipeEvent event, Emitter<ProductDetailState> emit) {
    emit(ProductDetailSuccess(shoeDetailsEntity: event.shoeVariations));
  }
}
