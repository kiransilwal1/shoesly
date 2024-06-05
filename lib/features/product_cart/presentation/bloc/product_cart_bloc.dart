import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/cubit/cart_status_cubit.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/product_cart/domain/entities/bulk_add_params.dart';
import 'package:shoesly/features/product_cart/domain/usecases/add_product_to_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/bulkAddToCart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/remove_from_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/view_cart.dart';

import '../../../../core/entities/product_variation.dart';
import '../../domain/entities/cart.dart';
import '../../domain/usecases/delete_from_cart.dart';
part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  final ProductAddToCartUseCase _productAddToCart;
  final ViewCartUseCase _viewCartUseCase;
  final BulkAddToCartUseCase _bulkAddToCartUseCase;
  final DeleteFromCartUseCase _deleteFromCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final CartStatusCubit _cartStatusCubit;
  ProductCartBloc({
    required ProductAddToCartUseCase productAddToCart,
    required ViewCartUseCase viewCartUseCase,
    required BulkAddToCartUseCase bulkAddToCartUseCase,
    required DeleteFromCartUseCase deleteFromCartUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required CartStatusCubit cartStatusCubit,
  })  : _productAddToCart = productAddToCart,
        _viewCartUseCase = viewCartUseCase,
        _bulkAddToCartUseCase = bulkAddToCartUseCase,
        _deleteFromCartUseCase = deleteFromCartUseCase,
        _removeFromCartUseCase = removeFromCartUseCase,
        _cartStatusCubit = cartStatusCubit,
        super(ProductCartInitial()) {
    on<ProductCartEvent>((event, emit) {
      emit(ProductCartInitial());
    });
    on<AddToCart>(_addToCart);
    on<ViewCartEvent>(_viewCart);
    on<RemoveFromCart>(_removeFromCart);
    on<BulkAddEvent>(_bulkAddToCart);
    on<DeleteEvent>(_deleteFromCart);
  }

  FutureOr<void> _addToCart(
      AddToCart event, Emitter<ProductCartState> emit) async {
    final res = await _productAddToCart(event.product);
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => _updateCartStatus(cart: r, emit: emit));
  }

  FutureOr<void> _viewCart(
      ViewCartEvent event, Emitter<ProductCartState> emit) async {
    emit(ProductCartInitial());
    final res = await _viewCartUseCase(NoParams());
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => _updateCartStatus(cart: r, emit: emit));
  }

  FutureOr<void> _removeFromCart(
      RemoveFromCart event, Emitter<ProductCartState> emit) async {
    emit(ProductCartInitial());
    final res = await _removeFromCartUseCase(event.product);
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => _updateCartStatus(cart: r, emit: emit));
  }

  FutureOr<void> _bulkAddToCart(
      BulkAddEvent event, Emitter<ProductCartState> emit) async {
    final res = await _bulkAddToCartUseCase(
        BulkAddParams(productVariation: event.product, count: event.quantity));
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => _updateCartStatus(cart: r, emit: emit));
  }

  FutureOr<void> _deleteFromCart(
      DeleteEvent event, Emitter<ProductCartState> emit) async {
    emit(ProductCartInitial());
    final res = await _deleteFromCartUseCase(event.product);
    res.fold((l) => emit(ProductCartFailure(errorMessage: l.message)),
        (r) => _updateCartStatus(cart: r, emit: emit));
  }

  void _updateCartStatus(
      {required Cart cart, required Emitter<ProductCartState> emit}) {
    _cartStatusCubit.updateStatus(cart);
    emit(ProductCartSuccess(cart: cart));
  }
}
