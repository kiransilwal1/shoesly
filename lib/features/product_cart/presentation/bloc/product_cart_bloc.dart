import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/product_cart/domain/usecases/add_product_to_cart.dart';

import '../../domain/entities/cart.dart';
import '../../../../core/entities/product_variations.dart';
part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  final ProductAddToCartUseCase _productAddToCart;
  ProductCartBloc({required ProductAddToCartUseCase productAddToCart})
      : _productAddToCart = productAddToCart,
        super(ProductCartInitial()) {
    on<ProductCartEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddToCart>(_addToCart);
  }

  FutureOr<void> _addToCart(
      AddToCart event, Emitter<ProductCartState> emit) async {
    final res = await _productAddToCart(event.product);
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => emit(ProductCartSuccess(cart: r)));
  }
}
