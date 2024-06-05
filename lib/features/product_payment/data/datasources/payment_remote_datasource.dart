import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/core/models/product_variation_model.dart';
import 'package:shoesly/features/product_cart/domain/entities/cart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/models/cart_model.dart';
import '../models/order_model.dart';

abstract interface class PaymentRemoteDatasource {
  Future<String> initiatePayment(Cart cart);

  Future<CartModel> checkout(Cart cart);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDatasource {
  final SupabaseClient db;
  final SharedPreferences cache;

  PaymentRemoteDataSourceImpl({required this.cache, required this.db});
  @override
  Future<String> initiatePayment(cart) async {
    //TODO: For now the database doesn't have a pivot table that relates product_variation to product. Need to do that if the vendor offers product that doesn't have variations. Need different product_item table that will work as pivot.
    try {
      double sum =
          cart.products.map((item) => item.price).reduce((a, b) => a + b);

      OrderModel orderModel = OrderModel(
          customerId: Constants.customerId,
          orderStatus: 'Success',
          totalAmount: sum + Constants.kDeliveryCharge,
          paymentStatus: 'Success',
          paymentMethod: 'Online',
          shippingAddress: 'shippingAddress',
          items: cart.products);
      final response =
          await db.from('orders').insert(orderModel.toMap()).select();
      await cache.clear();
      return response[0]['tracking_id'].toString();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
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
