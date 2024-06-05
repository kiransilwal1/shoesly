import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/product_payment/domain/usecases/checkout_usecase.dart';
import 'package:shoesly/features/product_payment/domain/usecases/product_payment_initiate_useecase.dart';

import '../../../product_cart/domain/entities/cart.dart';

part 'paywall_event.dart';
part 'paywall_state.dart';

class ProductPaymentBloc
    extends Bloc<ProductPaymentEvent, ProductPaymentState> {
  final ProductPaymentInitiateUsecase _productPaymentInitiateUseecase;
  final CheckoutUseCase _checkoutUseCase;
  ProductPaymentBloc(
      {required ProductPaymentInitiateUsecase productPaymentInitiateUseecase,
      required CheckoutUseCase checkOutUsecase})
      : _productPaymentInitiateUseecase = productPaymentInitiateUseecase,
        _checkoutUseCase = checkOutUsecase,
        super(ProductPaymentInitial()) {
    on<ProductPaymentEvent>((event, emit) {});
    on<PaymentInitiated>(_intiatePayment);
    on<CheckOut>(_initateCheckOut);
  }

  FutureOr<void> _intiatePayment(
      PaymentInitiated event, Emitter<ProductPaymentState> emit) async {
    final res = await _productPaymentInitiateUseecase(event.cart);
    res.fold((l) => emit(ProductPaymentFailure(errorMessage: l.message)),
        (r) => emit(ProductPaymentSuccess(trackingId: r)));
  }

  FutureOr<void> _initateCheckOut(
      CheckOut event, Emitter<ProductPaymentState> emit) async {
    final res = await _checkoutUseCase(event.cart);
    res.fold((l) => emit(ProductPaymentFailure(errorMessage: l.message)),
        (r) => emit(CheckoutSuccess(cart: r)));
  }
}
