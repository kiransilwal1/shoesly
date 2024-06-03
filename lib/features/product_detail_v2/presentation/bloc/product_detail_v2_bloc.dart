import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoesly/features/product_detail_v2/domain/entities/product_detail_entity.dart';
import 'package:shoesly/features/product_detail_v2/domain/usecases/product_detail_load_usecase.dart';

part 'product_detail_v2_event.dart';
part 'product_detail_v2_state.dart';

class ProductDetailV2Bloc
    extends Bloc<ProductDetailV2Event, ProductDetailV2State> {
  final ProductDetailLoadUseCase _productDetailLoadUseCase;
  ProductDetailV2Bloc({
    required ProductDetailLoadUseCase productDetailLoadUseCase,
  })  : _productDetailLoadUseCase = productDetailLoadUseCase,
        super(ProductDetailV2Initial()) {
    on<ProductDetailV2Event>((event, emit) {
      // TODO: implement event handler
    });
    on<ProductDetailLoadEvent>(_loadProductEvent);
  }

  FutureOr<void> _loadProductEvent(
      ProductDetailLoadEvent event, Emitter<ProductDetailV2State> emit) async {
    emit(ProductDetailV2Initial());
    final res = await _productDetailLoadUseCase(event.id);
    res.fold((l) => emit(ProudctDetailV2Failure(errorMessage: l.message)),
        (r) => emit(ProductDetailV2Success(productDetailEntity: r)));
  }
}
