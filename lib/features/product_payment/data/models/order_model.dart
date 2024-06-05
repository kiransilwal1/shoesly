import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shoesly/core/models/product_variation_model.dart';

import '../../domain/entities/order_entites.dart';

class OrderModel extends Order {
  OrderModel(
      {super.orderId,
      required super.customerId,
      super.orderDate,
      required super.orderStatus,
      required super.totalAmount,
      required super.paymentStatus,
      required super.paymentMethod,
      required super.shippingAddress,
      required super.items});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderId,
      'customer_id': customerId,
      'order_status': orderStatus,
      'total_amount': totalAmount,
      'payment_status': paymentStatus,
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress,
      'items': items.map((x) => (x as ProductVariationModel).toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['order_id'] as String,
      customerId: map['customer_id'] as String,
      orderDate: DateTime.parse(map['order_date']),
      orderStatus: map['order_status'] as String,
      totalAmount: map['total_amount'] as double,
      paymentStatus: map['payment_status'] as String,
      paymentMethod: map['payment_method'] as String,
      shippingAddress: map['shipping_address'] as String,
      items: List<ProductVariationModel>.from(
        (map['items'] as List<int>).map<ProductVariationModel>(
          (x) => ProductVariationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(orderId: $orderId, customerId: $customerId, orderDate: $orderDate, orderStatus: $orderStatus, totalAmount: $totalAmount, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, shippingAddress: $shippingAddress, items: $items)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.customerId == customerId &&
        other.orderDate == orderDate &&
        other.orderStatus == orderStatus &&
        other.totalAmount == totalAmount &&
        other.paymentStatus == paymentStatus &&
        other.paymentMethod == paymentMethod &&
        other.shippingAddress == shippingAddress &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        customerId.hashCode ^
        orderDate.hashCode ^
        orderStatus.hashCode ^
        totalAmount.hashCode ^
        paymentStatus.hashCode ^
        paymentMethod.hashCode ^
        shippingAddress.hashCode ^
        items.hashCode;
  }
}
