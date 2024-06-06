// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoesly/core/common/theme/app_theme.dart';
import 'package:shoesly/core/common/widgets/buttons/button_styles.dart';

import 'package:shoesly/features/product_discover/presentation/pages/product_discover_page.dart';
import 'package:shoesly/features/product_payment/presentation/pages/order_summary.dart';
import 'package:shoesly/core/entities/product_variation.dart';
import '../../../../core/common/widgets/alert.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
import '../../../../core/common/widgets/standard_app_bar.dart';
import '../../../product_payment/presentation/bloc/paywall_bloc.dart';
import '../bloc/product_cart_bloc.dart';
import '../widgets/cart_list_view.dart';
import '../widgets/empty_cart_case.dart';
import '../widgets/shimmer_cart_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<ProductCartBloc>().add(ViewCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCartBloc, ProductCartState>(
      listener: (context, state) {
        if (state is ProductCartFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is ProductCartSuccess) {
          if (state.cart.products.isEmpty) {
            return const EmptyCartCase();
            //TODO: Another shittiest way to do things. In v2, the bloc shall be removed from the scaffold.
          }
          double grandTotal =
              state.cart.products.fold(0, (sum, item) => sum + item.price);
          return Scaffold(
            bottomSheet: Container(
              height: 90,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GRAND TOTAL',
                          style: AppTheme.body100
                              .copyWith(color: AppTheme.neutral300),
                        ),
                        Text(
                          grandTotal.toStringAsFixed(2),
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'CHECK OUT'),
                      onPressed: () {
                        context
                            .read<ProductPaymentBloc>()
                            .add(CheckOut(cart: state.cart));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderSummary()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            appBar: PreferredSize(
                preferredSize: Size(0, 90),
                child: StandardAppBar(
                  title: 'Cart',
                  onBack: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            const ProductDiscoverPage(),
                        transitionDuration: Duration(milliseconds: 100),
                        transitionsBuilder: (_, anim, __, child) =>
                            FadeTransition(opacity: anim, child: child),
                      ),
                    );
                  },
                )),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 100),
              child: CartListView(itemList: state.cart.products),
            ),
          );
        } else {
          return const ShimmerCartPage();
        }
      },
    );
  }
}
