import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoesly/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shoesly/features/product_detail/domain/usecases/product_detail_load_usecase.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailLoadUseCase _productDetailLoadUseCase;
  ProductDetailBloc({
    required ProductDetailLoadUseCase productDetailLoadUseCase,
  })  : _productDetailLoadUseCase = productDetailLoadUseCase,
        super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ProductDetailLoadEvent>(_loadProductEvent);
  }

  FutureOr<void> _loadProductEvent(
      ProductDetailLoadEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailInitial());
    final res = await _productDetailLoadUseCase(event.id);
    res.fold((l) => emit(ProudctDetailFailure(errorMessage: l.message)),
        (r) => emit(ProductDetailSuccess(productDetailEntity: r)));
  }
}
