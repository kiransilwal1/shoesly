import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/cart.dart';

part 'cart_status_state.dart';

class CartStatusCubit extends Cubit<CartStatusState> {
  CartStatusCubit() : super(CartStatusInitial());

  void updateStatus(Cart cart) {
    if (cart.products.isEmpty) {
      emit(CartStatusInitial());
    } else {
      emit(CartStatusLoaded());
    }
  }
}
