import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/minimal_buttons.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/entities/cart.dart';
import '../bloc/paywall_bloc.dart';

class OrderSummaryBottomSheet extends StatelessWidget {
  const OrderSummaryBottomSheet(
      {super.key, required this.grandTotal, required this.cart});

  final double grandTotal;
  final Cart cart;

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
                  '\$${(grandTotal + Constants.kDeliveryCharge).toStringAsFixed(2)}',
                  style:
                      AppTheme.headline600.copyWith(color: AppTheme.neutral500),
                ),
              ],
            ),
            PrimaryButton(
              isDisabled: false,
              style: const LabelButtonStyle(text: 'PAYMENT'),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      title: Text(
                        "Confirm",
                        style: AppTheme.headline600
                            .copyWith(color: AppTheme.error600),
                      ),
                      actionsPadding: EdgeInsets.all(16.0),
                      contentTextStyle:
                          AppTheme.body500.copyWith(color: AppTheme.neutral400),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      content: const Text(
                          "Are you sure you wish to make the payments?"),
                      actions: <Widget>[
                        MinimalButton(
                          isDisabled: false,
                          style: const LabelButtonStyle(text: 'NO'),
                          color: AppTheme.error600,
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        MinimalButton(
                            isDisabled: false,
                            style: const LabelButtonStyle(text: 'YES'),
                            onPressed: () {
                              context
                                  .read<ProductPaymentBloc>()
                                  .add(PaymentInitiated(cart: cart));
                            }),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
