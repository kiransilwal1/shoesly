import 'package:shoesly/core/entities/product_variation.dart';

//TODO: shipping address needs to be json, for now it is string.
class Order {
  String? orderId;
  String customerId;
  DateTime? orderDate;
  String orderStatus;
  double totalAmount;
  String paymentStatus;
  String paymentMethod;
  String shippingAddress;
  List<ProductVariation> items;
  Order({
    required this.orderId,
    required this.customerId,
    this.orderDate,
    required this.orderStatus,
    required this.totalAmount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.items,
  });
}
