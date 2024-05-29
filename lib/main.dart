import 'package:flutter/material.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/features/cart/presentation/pages/cart_page.dart';
import 'package:shoesly/features/discover/presentation/pages/discover_page.dart';
import 'package:shoesly/features/paywall/presentation/pages/order_summary.dart';
import 'package:shoesly/features/product-detail/presentation/pages/product_detail.dart';
import 'package:shoesly/features/product_filter/presentation/pages/product_filter.dart';
import 'package:shoesly/features/product_review/presentation/pages/product_review.dart';

void main() {
  runApp(const Shoesly());
}

class Shoesly extends StatelessWidget {
  const Shoesly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoesly',
      debugShowCheckedModeBanner: false,
      home: OrderSummary(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: MinimalButton(
              isDisabled: true,
              style: LeadingIconStyle(
                  text: 'label',
                  leadingIconImagePath: 'assets/icons/add-cirlce.png'))),
    );
  }
}
