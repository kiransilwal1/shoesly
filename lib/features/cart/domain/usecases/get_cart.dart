import '../entities/cart.dart';
import '../repositories/cart_repo.dart';

class GetCart {
  final CartRepository repository;

  GetCart({required this.repository});

  Stream<Cart> call() {
    return repository.getCart();
  }
}
