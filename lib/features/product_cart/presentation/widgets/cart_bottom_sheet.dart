import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
import '../../../../core/entities/cart.dart';
import '../../../product_payment/presentation/bloc/paywall_bloc.dart';
import '../../../product_payment/presentation/pages/order_summary.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    super.key,
    required this.grandTotal,
    required this.cart,
  });
  final Cart cart;
  final double grandTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  style: AppTheme.body100.copyWith(color: AppTheme.neutral300),
                ),
                Text(
                  grandTotal.toStringAsFixed(2),
                  style:
                      AppTheme.headline600.copyWith(color: AppTheme.neutral500),
                ),
              ],
            ),
            PrimaryButton(
              isDisabled: false,
              style: const LabelButtonStyle(text: 'CHECK OUT'),
              onPressed: () {
                context.read<ProductPaymentBloc>().add(CheckOut(cart: cart));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderSummary()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
