import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_cart/domain/usecases/add_product_to_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/view_cart.dart';

import '../../../product_detail_v2/domain/entities/product_variation.dart';
import '../../domain/entities/cart.dart';
part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  final ProductAddToCartUseCase _productAddToCart;
  final ViewCartUseCase _viewCartUseCase;
  ProductCartBloc(
      {required ProductAddToCartUseCase productAddToCart,
      required ViewCartUseCase viewCartUseCase})
      : _productAddToCart = productAddToCart,
        _viewCartUseCase = viewCartUseCase,
        super(ProductCartInitial()) {
    on<ProductCartEvent>((event, emit) {
      emit(ProductCartInitial());
    });
    on<AddToCart>(_addToCart);
    on<ViewCartEvent>(_viewCart);
    on<RemoveFromCart>(_removeFromCart);
  }

  FutureOr<void> _addToCart(
      AddToCart event, Emitter<ProductCartState> emit) async {
    final res = await _productAddToCart(event.product);
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => emit(ProductCartSuccess(cart: r)));
  }

  FutureOr<void> _viewCart(
      ViewCartEvent event, Emitter<ProductCartState> emit) async {
    emit(ProductCartInitial());
    final res = await _viewCartUseCase(NoParams());
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => emit(ProductCartSuccess(cart: r)));
  }

  FutureOr<void> _removeFromCart(
      RemoveFromCart event, Emitter<ProductCartState> emit) {}
}
