import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/cart/domain/usecases/add_to_cart.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';
import '../../domain/entities/cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_from_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final GetCart getCart;

  CartBloc({
    required this.addToCart,
    required this.removeFromCart,
    required this.getCart,
  }) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());
      final cartItems = await getCart();
      emit(CartLoaded(cartItems));
    });

    on<AddToCartEvent>((event, emit) async {
      await addToCart(event.shoe);
    });

    on<RemoveFromCartEvent>((event, emit) async {
      await removeFromCart(event.shoe);
    });
  }
}
