import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/core/models/product_variation_model.dart';
import 'package:shoesly/features/product_cart/domain/entities/cart.dart';

import '../../../../core/models/cart_model.dart';

abstract interface class PaymentRemoteDatasource {
  Future<CartModel> initiatePayment();

  Future<CartModel> checkout(Cart cart);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDatasource {
  @override
  Future<CartModel> initiatePayment() async {
    // TODO: implement initiatePayment
    throw UnimplementedError();
  }

  @override
  Future<CartModel> checkout(Cart cart) async {
    try {
      return await CartModel(
          products: cart.products
              .map((e) => ProductVariationModel(
                  id: e.id,
                  colorCode: e.colorCode,
                  colorName: e.colorName,
                  image: e.image,
                  size: e.size,
                  createdAt: e.createdAt,
                  price: e.price,
                  productId: e.productId,
                  brandname: e.brandname,
                  title: e.title,
                  brandimage: e.brandimage))
              .toList());
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on PaymentException catch (e) {
      throw PaymentException(message: e.message);
    }
  }
}
