import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/usecase/usecase.dart';
import 'package:shoesly/features/cart/domain/entities/cart_items.dart';

import 'package:shoesly/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:shoesly/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:shoesly/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:shoesly/features/cart/domain/usecases/swipe_to_delete_usecase.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

import '../../../product_detail_v2/domain/entities/product_variation.dart';
import '../../domain/entities/cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final SwipeToDeleteUseCase _swipeToDeleteUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final GetCartUsecase _getCartUsecase;
  final AddToCartUsecase _addToCartUsecase;
  CartBloc({
    required SwipeToDeleteUseCase swipeToDeleteUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required GetCartUsecase getCartUsecase,
    required AddToCartUsecase addToCartUsecase,
  })  : _swipeToDeleteUseCase = swipeToDeleteUseCase,
        _removeFromCartUseCase = removeFromCartUseCase,
        _getCartUsecase = getCartUsecase,
        _addToCartUsecase = addToCartUsecase,
        super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>((event, emit) {});
    on<SwipeToDeleteEvent>((event, emit) async {
      final res = await _swipeToDeleteUseCase(CartItems(
          id: event.shoe.id,
          variations: event.shoe,
          quantity: event.quantity,
          totalItemPrice: event.shoe.price * event.quantity));
      res.fold((l) => emit(CartFailure(errorMessage: l.message)),
          (r) => emit(CartLoadedState(cart: r)));
    });
    on<GetCartEvent>((event, emit) async {
      final res = await _getCartUsecase(NoParams());
      res.fold((l) => emit(CartFailure(errorMessage: l.message)),
          (r) => emit(CartLoadedState(cart: r)));
    });
  }

  FutureOr<void> _addToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    final res = await _addToCartUsecase(CartItems(
        id: event.shoe.id,
        variations: event.shoe,
        quantity: event.quantity,
        totalItemPrice: event.quantity * event.shoe.salePrice));
    res.fold((l) => emit(CartFailure(errorMessage: l.message)),
        (r) => emit(CartInitial()));
  }
}
