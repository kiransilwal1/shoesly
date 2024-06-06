import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/entities/product_variation.dart';
import '../bloc/product_cart_bloc.dart';

class CartAdd extends StatefulWidget {
  const CartAdd({super.key, required this.product, required this.productCount});

  @override
  _CartAddState createState() => _CartAddState();
  final ProductVariation product;
  final int productCount;
}

class _CartAddState extends State<CartAdd> {
  late int _productCount;

  @override
  void initState() {
    super.initState();
    _productCount = widget.productCount;
  }

  void _incrementCounter() {
    context.read<ProductCartBloc>().add(AddToCart(product: widget.product));
    setState(() {
      _productCount++;
    });
  }

  void _decrementCounter() {
    if (_productCount > 0) {
      context.read<ProductCartBloc>().add(DeleteEvent(product: widget.product));
      setState(() {
        _productCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.product.price * _productCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: _decrementCounter,
          padding: EdgeInsets.zero,
          icon: Image.asset(
            'assets/icons/minus-cirlce.png',
            width: 24,
            height: 24,
            color: _productCount > 0 ? AppTheme.neutral500 : Colors.grey,
          ),
        ),
        Text(
          '$_productCount',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          onPressed: _incrementCounter,
          padding: EdgeInsets.zero,
          icon: Image.asset(
            'assets/icons/add-circle.png',
            width: 24,
            height: 24,
            color: AppTheme.neutral500,
          ),
        ),
        Text(
          '\$${totalPrice.toStringAsFixed(2)}',
          style: AppTheme.headline600.copyWith(color: AppTheme.neutral500),
        ),
      ],
    );
  }
}
