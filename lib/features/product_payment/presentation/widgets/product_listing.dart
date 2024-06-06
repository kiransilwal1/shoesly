import 'package:flutter/material.dart';

import '../../../../core/entities/cart.dart';
import '../../../../core/entities/product_variation.dart';
import 'item_detail_widget.dart';

class DisplayProducts extends StatelessWidget {
  const DisplayProducts({
    super.key,
    required this.cart,
  });
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (ProductVariation items in cart.products.toSet().toList())
          OrderDetailWidget(
            itemTitle: items.title,
            itemDescription:
                '${items.brandname} . ${items.colorName} . ${items.size}',
            itemQuantity:
                cart.products.where((element) => element.id == items.id).length,
            itemPrice:
                '\$${(cart.products.where((element) => element.id == items.id).length * items.price).toStringAsFixed(2)}',
          )
      ],
    );
  }
}
